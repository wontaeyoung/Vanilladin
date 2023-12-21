import UIKit

struct Book: EntityProtocol {
    let id: UUID
    let title: String
    let author: String
    let description: String
    let priceSales: Int
    let priceStandard: Int
    let mileage: Int
    let coverImage: UIImage?
    let coverURL: String
    let publisher: String
    let isbn13: String
}
