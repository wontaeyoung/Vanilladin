import UIKit

struct BookResult: Codable {
    let totalResults: Int
    let startIndex: Int
    let itemsPerPage: Int
    let item: [BookDTO]
}

struct SubInfo: Codable {
    let ratingInfo: RatingInfo
}

struct RatingInfo: Codable {
    let ratingScore: Double
    let ratingCount: Int
    let commentReviewCount: Int
    let myReviewCount: Int
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
    let subInfo: SubInfo
    
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
            publisher: publisher,
            ratingScore: subInfo.ratingInfo.ratingScore,
            ratingCount: subInfo.ratingInfo.ratingCount,
            commentReviewCount: subInfo.ratingInfo.commentReviewCount,
            myReviewCount: subInfo.ratingInfo.myReviewCount)
    }
}
