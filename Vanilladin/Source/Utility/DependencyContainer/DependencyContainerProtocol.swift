protocol DependencyContainerProtocol: DependencyContainable {
    func register<T: DependencyContainable>(instance: T)
    func resolve<T: DependencyContainable>() throws -> T
    func setDependency()
}
