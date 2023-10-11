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
    
    private let priceValueLabel: UILabel = {
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
        priceValueLabel.text = price.asPriceFormat
    }
    
    override func setHierarchy() {
        addSubviews(priceImage, priceValueLabel)
    }
    
    override func setConstraint() {
        setTranslatesAutoresizingMaskIntoConstraintsOff(priceImage, priceValueLabel)
        
        NSLayoutConstraint.activate([
            priceImage.topAnchor.constraint(equalTo: self.topAnchor),
            priceImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceImage.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            priceValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            priceValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceValueLabel.leadingAnchor.constraint(equalTo: priceImage.trailingAnchor, constant: 10),
        ])
    }
}
