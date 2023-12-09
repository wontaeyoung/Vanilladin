protocol WritableEntityProtocol: EntityProtocol {
    associatedtype DTO: DTOProtocol
    
    func asModel()
}
