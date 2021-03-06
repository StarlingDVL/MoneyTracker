//
//  StorageManager.swift
//  MoneyTracker
//
//  Created by Юрий Скворцов on 17.06.2022.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data Stack
    
    private let context: NSManagedObjectContext
    var fetchResulController: NSFetchedResultsController<Operation> {
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let fetchRequest = Operation.fetchRequest()
        
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch let error{
            print(error)
        }
        
        return controller
    }
    
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoneyTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    //MARK: - Fetching Methods
    
    func fetchOperationData(completion: (Result<[Operation], Error>) -> Void) {
        let fetchRequest = Operation.fetchRequest()
        
        do {
            let operations = try context.fetch(fetchRequest)
            completion(.success(operations))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func fetchCategoriesData(completion: (Result<[Category], Error>) -> Void) {
        let fetchRequest = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(fetchRequest)
            completion(.success(categories))
        } catch let error {
            completion(.failure(error))
        }
    }
   
    func fetchData() {
        func fetchOperationData(completion: (Result<[Operation], Error>) -> Void) {
            let fetchRequest = Operation.fetchRequest()
            
            do {
                let operations = try context.fetch(fetchRequest)
                completion(.success(operations))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        func fetchCategoriesData(completion: (Result<[Category], Error>) -> Void) {
            let fetchRequest = Category.fetchRequest()
            
            do {
                let categories = try context.fetch(fetchRequest)
                completion(.success(categories))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Saving Methods
    
    func saveOperation(sum: Int, category: Category, completion: (Operation) -> Void ) {
        let operation = Operation(context: context)
        operation.sum = Int32(sum)
        operation.category = category
        operation.date = Date()
        completion(operation)
        
        saveContext()
    }
    
    func deleteOperation(_ operation: Operation) {
        context.delete(operation)
        saveContext()
    }
    
    func saveCategory(title: String, image: Data, isExpense: Bool) {
        let category = Category(context: context)
        category.title = title
        category.image = image
        category.isExpense = isExpense
        
        saveContext()
    }
    
    
    // MARK: - Core Data Saving Support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
