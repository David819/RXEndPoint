//
//  HistoryListViewModel.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryListViewModel {
    
    // MARK: - PROPERTIES
    
    var records: PublishSubject<[Record]> {
        CoreDataService.shared.rcds
    }
    
    func fetch() {
        CoreDataService.shared.fetch()
    }
}
