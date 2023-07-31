final class DependencyContainer: DependencyContainerProtocol {
    
    // MARK: - Stored Property
    static let shared: DependencyContainer = .init()
    private var registry: [ObjectIdentifier : DependencyContainable] = [:]
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Method
    func register<T: DependencyContainable>(
        instance: T
    ) {
        let key: ObjectIdentifier = .init(T.self)
        
        registry.updateValue(
            instance,
            forKey: key
        )
    }
    
    func resolve<T: DependencyContainable>(
        _ factory: @escaping () -> T
    ) -> T {
        let key: ObjectIdentifier = .init(T.self)
        
        guard let instance: T = registry[key] as? T else {
            let newInstance: T = factory()
            
            register(instance: newInstance)
            
            return newInstance
        }
        
        return instance
    }
}
