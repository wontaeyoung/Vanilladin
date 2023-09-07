import UIKit

struct Result: Codable {
    let totalResults: Int
    let startIndex: Int
    let itemsPerPage: Int
    let item: [BookDTO]
}

struct BookDTO: DTOProtocol {
    typealias Entity = Book
    
    let title: String
    let author: String
    let description: String
    let priceSales: Int
    let priceStandard: Int
    let mileage: Int
    let cover: String
    let publisher: String
    
    func asModel(with coverImage: UIImage) -> Book {
        .init(
            id: UUID(),
            title: title,
            author: author,
            description: description,
            priceSales: priceSales,
            priceStandard: priceStandard,
            mileage: mileage,
            coverImage: coverImage,
            publisher: publisher
        )
    }
}
