import Foundation

protocol DTOProtocol: Codable {
    associatedtype Entity: EntityProtocol
    
    func asModel(with coverImage: Data) -> Entity
}
