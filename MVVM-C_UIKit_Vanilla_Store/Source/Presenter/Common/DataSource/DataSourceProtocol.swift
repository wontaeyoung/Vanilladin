protocol DataSourceProtocol: DependencyContainable {
    associatedtype Entity = EntityProtocol
    
    var entities: [Entity] { get set }
}
