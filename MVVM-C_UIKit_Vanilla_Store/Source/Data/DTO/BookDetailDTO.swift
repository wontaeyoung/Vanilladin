import UIKit

struct LookupBookResult: Codable {
    let item: [BookDetailDTO]
}

struct BookDetailDTO: DTOProtocol {
    let subInfo: SubInfo
    
    func asModel(with coverImage: UIImage?) -> BookDetail {
        .init(
            id: UUID(),
            itemPage: subInfo.itemPage,
            ratingScore: subInfo.ratingInfo.ratingScore,
            ratingCount: subInfo.ratingInfo.ratingCount,
            commentReviewCount: subInfo.ratingInfo.commentReviewCount,
            myReviewCount: subInfo.ratingInfo.myReviewCount,
            width: subInfo.packing.width,
            height: subInfo.packing.height,
            depth: subInfo.packing.depth,
            weight: subInfo.packing.weight)
    }
}

struct SubInfo: Codable {
    let itemPage: Int
    let ratingInfo: RatingInfo
    let packing: PackingInfo
}

struct RatingInfo: Codable {
    let ratingScore: Double
    let ratingCount: Int
    let commentReviewCount: Int
    let myReviewCount: Int
}

struct PackingInfo: Codable {
    let width: Int
    let height: Int
    let depth: Int
    let weight: Int
}
