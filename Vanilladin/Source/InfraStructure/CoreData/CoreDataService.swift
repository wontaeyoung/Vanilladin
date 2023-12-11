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
}
