import UIKit

struct Result: Codable {
    let item: [BookDTO]
}

struct BookDTO: DTOProtocol {
    let title: String
    let author: String
    let description: String
    let pricesales: Int
    let pricestandard: Int
    let mileage: Int
    let cover: String
    let publisher: String
    
    func asModel(image coverImage: UIImage) -> Book {
        .init(id: UUID(),
              title: title,
              author: author,
              description: description,
              priceSales: pricesales,
              priceStandard: pricestandard,
              mileage: mileage,
              coverImage: coverImage,
              publisher: publisher
        )
    }
}
