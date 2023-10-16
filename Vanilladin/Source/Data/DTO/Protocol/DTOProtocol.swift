import UIKit

protocol DTOProtocol: Codable {
    associatedtype Entity: EntityProtocol
    
    func asModel(with coverImage: UIImage?) -> Entity
}
