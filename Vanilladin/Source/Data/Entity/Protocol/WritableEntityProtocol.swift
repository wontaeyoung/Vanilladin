import CoreData

protocol WritableEntityProtocol: EntityProtocol {
    associatedtype DTO: NSManagedObject
    
    func asDTO() -> DTO
}
