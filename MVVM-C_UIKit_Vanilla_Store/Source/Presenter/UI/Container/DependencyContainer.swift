final class DependencyContainer: DependencyContainerProtocol {

    // MARK: - Stored Property
    private var registry: [ObjectIdentifier : DependencyContainable] = [:]
    
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
