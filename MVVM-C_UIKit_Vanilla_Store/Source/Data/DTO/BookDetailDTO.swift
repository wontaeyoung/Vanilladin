struct SubInfo: Codable {
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
