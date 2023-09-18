import UIKit

final class RatingView: BaseView {
    // MARK: - Property
    private let ratingScore: Int
    
    // MARK: - UI
    private let starStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    // MARK: - Initializer
    init(ratingScore: Double) {
        self.ratingScore = Int(ratingScore)
        
        super.init()
    }
    
    // MARK: - Method
    private func setStars(ratingScore: Int) {
        let fullStarCount: Int = ratingScore / 2
        let hasHalfStar: Bool = ratingScore % 2 == 1
        
        for starNum in 1...UIConstant.Rating.maxStarRatingCount {
            let imageView: UIImageView = {
                let imageView: UIImageView = .init()
                imageView.contentMode = .scaleAspectFit
                
                return imageView
            }()
            
            let symbol: String = starNum <= fullStarCount
            ? UIConstant.SFSymbol.starFill
            : hasHalfStar
            ? UIConstant.SFSymbol.starLeadinghalfFill
            : UIConstant.SFSymbol.star
            
            imageView.image = UIImage(systemName: symbol)
            
            starStackView.addArrangedSubview(imageView)
        }
    }
}
