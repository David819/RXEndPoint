//
//  CoreDataService.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class CoreDataService {
    
    // MARK: - PROPERTIES
    
    static let shared = CoreDataService()
    let rcds = PublishSubject<[Record]>()

    private let viewContext = PersistentController.shared.container.viewContext
    private var fetchRequest: NSFetchRequest<Record> {
        let fetchRequest = NSFetchRequest<Record>(entityName: "Record")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeInterval", ascending: false)]
        return fetchRequest
    }
    
    // MARK: - FUNCTIONS
    
    func fetch() {
        do {
            let result = try viewContext.fetch(fetchRequest)
            rcds
                .onNext(result)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func add(timeInterval: TimeInterval, data: Data) {
        let record = Record(context: viewContext)
        record.timeInterval = timeInterval
        record.jsonData = data
        PersistentController.shared.saveContext()
        fetch()
    }
}
