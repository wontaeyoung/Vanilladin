import CoreData

final class CoreDataService: DependencyContainable {
    // MARK: - Property
    lazy var container: NSPersistentContainer = setContainer()
    
    // MARK: - Initializer
    init() {
        container = setContainer()
    }
    
    // MARK: - Method
    private func setContainer() -> NSPersistentContainer {
        let container: NSPersistentContainer = .init(name: LogicConstant.CoreData.fileName)
        
        container.loadPersistentStores(completionHandler: { _, _ in })
        
        return container
    }
    
    func saveBookMemo(bookMemoDTO: BookMemoDTO) throws {
        let context: NSManagedObjectContext = container.viewContext
        let managedBookMemo: BookMemoDTO = .init(context: context)
        managedBookMemo.changePropertiesWith(bookMemoDTO)
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
    
    func fetchBookMemo(isbn13: String) throws -> BookMemoDTO {
        let context: NSManagedObjectContext = container.viewContext
        let request: NSFetchRequest<BookMemoDTO> = .init(entityName: LogicConstant.CoreData.bookMemoEntityName)
        request.predicate = NSPredicate(format: "isbn13 == %@", isbn13)

        guard let bookMemoDTO = try context.fetch(request).first else {
            throw CoreDataError.noResultWithQuery
        }
        
        return bookMemoDTO
    }
    
    func fetchBookMemos() throws -> [BookMemoDTO] {
        let context: NSManagedObjectContext = container.viewContext
        let request: NSFetchRequest<BookMemoDTO> = .init(entityName: LogicConstant.CoreData.bookMemoEntityName)
        
        do {
            let bookMemoDTOs: [BookMemoDTO] = try context.fetch(request)
            
            return bookMemoDTOs
        } catch {
            throw CoreDataError.entityNotFound
        }
    }
}
