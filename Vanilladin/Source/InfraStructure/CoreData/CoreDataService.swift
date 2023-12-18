import CoreData

final class CoreDataService: DependencyContainable {
    // MARK: - Property
    private lazy var container: NSPersistentContainer = setContainer()
    
    // MARK: - Method
    func saveMyBook(dto: MyBookDTO) throws {
        let context: NSManagedObjectContext = container.viewContext
        let managedMyBook: MyBookDTO = .init(context: context)
        managedMyBook.changePropertiesWith(dto)
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
    
    func updateMyBook(dto: MyBookDTO) throws {
        let context = getContext()
        let myBookDTO: MyBookDTO = try fetchMyBook(isbn13: dto.isbn13)
        myBookDTO.changePropertiesWith(dto)
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.storeConnectFailed
        }
    }
    
    func fetchMyBook(isbn13: String) throws -> MyBookDTO {
        let context = getContext()
        let request: NSFetchRequest<MyBookDTO> = .init(entityName: LogicConstant.CoreData.myBookEntityName)
        request.predicate = NSPredicate(format: "isbn13 == %@", isbn13)

        guard let bookMemoDTO = try context.fetch(request).first else {
            throw CoreDataError.noResultWithQuery
        }
        
        return bookMemoDTO
    }
    
    func fetchMyBooks() throws -> [MyBookDTO] {
        let context = getContext()
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
    
    func getContext() -> NSManagedObjectContext {
        return container.viewContext
    }
}
