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
    
    static var dummy: Self {
        .init(id: UUID(),
              itemPage: 0,
              ratingScore: 0,
              ratingCount: 0,
              commentReviewCount: 0,
              myReviewCount: 0,
              width: 0,
              height: 0,
              depth: 0,
              weight: 0)
    }
}
