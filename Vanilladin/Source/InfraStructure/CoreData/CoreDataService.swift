import CoreData

final class CoreDataService: DependencyContainable {
    // MARK: - Property
    private lazy var container: NSPersistentContainer = setContainer()
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Method
    func saveMyBook(dto: MyBookDTO) throws {
        let managedMyBook: MyBookDTO = .init(context: context)
        managedMyBook.changePropertiesWith(dto)
        
        try save()
    }
    
    func updateMyBook(dto: MyBookDTO) throws {
        let myBookDTO: MyBookDTO = try fetchMyBook(isbn13: dto.isbn13)
        myBookDTO.changePropertiesWith(dto)
        
        try save()
    }
    
    func fetchMyBook(isbn13: String) throws -> MyBookDTO {
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        request.predicate = NSPredicate(format: "isbn13 == %@", isbn13)

        guard let myBookDTO = try context.fetch(request).first else {
            throw CoreDataError.noResultWithQuery
        }
        
        return myBookDTO
    }
    
    func fetchMyBooks() async throws -> [MyBookDTO] {
        let backgroundContext = getBackgroundContext()
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        
        return try await backgroundContext.perform {
            defer {
                backgroundContext.reset()
            }
            
            do {
                return try backgroundContext.fetch(request)
            } catch {
                throw CoreDataError.entityNotFound
            }
        }
    }
    
    func isRegistered(isbn13: String) -> Bool {
        do {
            let dto: MyBookDTO = try fetchMyBook(isbn13: isbn13)
            
            return true
        } catch {
            return false
        }
    }
}

// MARK: - Private
private extension CoreDataService {
    func setContainer() -> NSPersistentContainer {
        let container: NSPersistentContainer = .init(name: LogicConstant.CoreData.fileName)
        
        container.loadPersistentStores(completionHandler: { _, _ in })
        
        return container
    }
    
    func getBackgroundContext() -> NSManagedObjectContext {
        return container.newBackgroundContext()
    }
    
    func save() throws {
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
}
