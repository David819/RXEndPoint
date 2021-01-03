//
//  CurrentViewModel.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import Foundation
import RxSwift
import RxCocoa

class CurrentViewModel {
    
    // MARK: - PROPERTIES
    
    let publishedStr = PublishSubject<String>()
    var publishedRcds: PublishSubject<[Record]> {
        CoreDataService.shared.rcds
    }
    
    private var bag = DisposeBag()
    
    // MARK: - FUNCTIONS
    
    init() {
        publishedRcds
            .subscribe { (rcdAry) in
                guard let str = rcdAry.element?.first?.timeInterval.toDateString() else {
                    self.publishedStr
                        .onNext("no history data fetch in 5s")
                    return
                }
                print(str)
                self.publishedStr
                    .onNext(str)
            }
            .disposed(by: bag)
    }
    
    func startLoad() {
        print("start load")
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {[weak self] in
            guard let strongSelf = self else { return }
            let _ = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler())
                .subscribe { (_) in
                    strongSelf.fetch()
                }
                .disposed(by: strongSelf.bag)
        }
    }
    
    func stopLoad() {
        print("stop load")
        self.bag = DisposeBag()
    }
    
    func loadHistory() {
        print("load history")
        CoreDataService.shared.fetch()
    }
    
    private func fetch() {
        let usersEP = UserEndpoint.getUsers(name: "defunkt")
        
        URLSession.shared.rx.response(request: usersEP.request)
            .subscribe {[weak self] (resp, data) in
                guard let strongSelf = self else { return }
                guard let str = String(data: data, encoding: .utf8) else { return }
                let timeInterval = Date().timeIntervalSince1970
                print(timeInterval.toDateString())
                strongSelf.publishedStr
                    .onNext(timeInterval.toDateString())
                print(str)
                CoreDataService.shared.add(timeInterval: timeInterval, data: data)

            } onError: { (err) in
                print(err.localizedDescription)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: bag)
    }
}
