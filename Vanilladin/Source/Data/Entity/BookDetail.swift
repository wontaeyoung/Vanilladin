import Foundation

struct BookDetail: EntityProtocol {
    struct Dimensions {
        let width: Int
        let height: Int
        let depth: Int
        let weight: Int
        
        init(width: Int, height: Int, depth: Int, weight: Int) {
            self.width = width
            self.height = height
            self.depth = depth
            self.weight = weight
        }
    }
    
    let id: UUID
    let itemPage: Int
    let ratingScore: Double
    let ratingCount: Int
    let commentReviewCount: Int
    let myReviewCount: Int
    let dimensions: Dimensions
    
    static var dummy: Self {
        .init(
            id: UUID(),
            itemPage: 0,
            ratingScore: 0,
            ratingCount: 0,
            commentReviewCount: 0,
            myReviewCount: 0,
            dimensions: .init(
                width: 0,
                height: 0,
                depth: 0,
                weight: 0)
        )
    }
}
