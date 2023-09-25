import UIKit

final class PriceView: BaseView {
    // MARK: - Property
    private let price: Int
    
    // MARK: - UI
    private let priceImage: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: UIConstant.SFSymbol.wonsignSquare)?
            .colored(with: .black)
        
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: UIConstant.FontSize.title)
        label.numberOfLines = .zero
        
        return label
    }()
    
    // MARK: - Initializer
    init(price: Int) {
        self.price = price
        
        super.init(frame: .zero)
    }
    
    // MARK: - Method
    override func setAttribute() {
        priceLabel.text = price.asPriceFormat
    }
    
    override func setHierarchy() {
        addSubviews(priceImage, priceLabel)
    }
    
    override func setConstraint() {
        setTranslatesAutoresizingMaskIntoConstraintsOff(priceImage, priceLabel)
        
        NSLayoutConstraint.activate([
            priceImage.topAnchor.constraint(equalTo: self.topAnchor),
            priceImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceImage.trailingAnchor, constant: 10),
        ])
    }
}
