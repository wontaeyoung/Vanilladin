import Foundation

struct BookDetail: EntityProtocol {
    let id: UUID
    let itemPage: Int
    let ratingScore: Double
    let ratingCount: Int
    let commentReviewCount: Int
    let myReviewCount: Int
    let width: Int
    let height: Int
    let depth: Int
    let weight: Int
}
