import CoreData

final class CoreDataService: DependencyContainable {
    // MARK: - Property
    private lazy var container: NSPersistentContainer = setContainer()
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Method
    func saveMyBook(dto: MyBookDTO) throws {
        let context: NSManagedObjectContext = container.viewContext
        let managedBookMemo: MyBookDTO = .init(context: context)
        managedBookMemo.changePropertiesWith(dto)
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
    
    func updateMyBook(dto: MyBookDTO) throws {
        let context: NSManagedObjectContext = container.viewContext
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        request.predicate = NSPredicate(format: "isbn13 == %@", dto.isbn13)
        
        guard let bookMemoDTO = try context.fetch(request).first else {
            throw CoreDataError.noResultWithQuery
        }
        
        bookMemoDTO.changePropertiesWith(dto)
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
    
    func fetchMyBook(isbn13: String) throws -> MyBookDTO {
        let context: NSManagedObjectContext = container.viewContext
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        request.predicate = NSPredicate(format: "isbn13 == %@", isbn13)

        guard let bookMemoDTO = try context.fetch(request).first else {
            throw CoreDataError.noResultWithQuery
        }
        
        return bookMemoDTO
    }
    
    func fetchMyBooks() throws -> [MyBookDTO] {
        let context: NSManagedObjectContext = container.viewContext
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        
        do {
            let bookMemoDTOs: [MyBookDTO] = try context.fetch(request)
            
            return bookMemoDTOs
        } catch {
            throw CoreDataError.entityNotFound
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
}
