import UIKit

final class RatingView: BaseView {
    // MARK: - Property
    private let ratingScore: Int
    
    // MARK: - Initializer
    init(ratingScore: Double) {
        self.ratingScore = Int(ratingScore)
        
        super.init()
    }
    
}
