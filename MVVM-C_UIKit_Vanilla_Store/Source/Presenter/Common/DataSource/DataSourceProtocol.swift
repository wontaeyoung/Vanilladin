protocol DataSourceProtocol {
    associatedtype Entity = EntityProtocol
    
    var entities: [Entity] { get set }
}
