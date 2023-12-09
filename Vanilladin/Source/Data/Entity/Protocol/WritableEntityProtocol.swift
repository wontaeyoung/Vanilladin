protocol WritableEntityProtocol: EntityProtocol {
    associatedtype DTO: DTOProtocol
    
    func asDTO() -> DTO
}
