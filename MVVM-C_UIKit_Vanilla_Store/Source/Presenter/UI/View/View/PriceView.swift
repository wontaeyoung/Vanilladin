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
    
    private let priceTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: UIConstant.FontSize.title)
        label.numberOfLines = .zero
        label.text = "판매가"
        
        return label
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
        priceValueLabel.text = "₩" + price.asPriceFormat
    }
    
    override func setHierarchy() {
        addSubviews(priceTitleLabel, priceValueLabel)
    }
    
    override func setConstraint() {
        setTranslatesAutoresizingMaskIntoConstraintsOff(priceTitleLabel, priceValueLabel)
        
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            priceTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            priceValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceValueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80)
        ])
    }
}
