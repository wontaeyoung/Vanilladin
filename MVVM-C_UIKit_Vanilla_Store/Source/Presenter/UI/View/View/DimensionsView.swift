import UIKit

final class DimensionsView: BaseView {
    // MARK: - Property
    private let dimensions: BookDetail.Dimensions
    
    // MARK: - UI
    private let rulerImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: UIConstant.SFSymbol.ruler)?
            .colored(with: .black)
        
        return imageView
    }()
    
    private let dimensionsValueLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.title)
        label.numberOfLines = .zero
        
        return label
    }()
    
    // MARK: - Initializer
    init(dimensions: BookDetail.Dimensions) {
        self.dimensions = dimensions
        
        super.init(frame: .zero)
    }
    
    // MARK: - Method
    override func setAttribute() {
        dimensionsValueLabel.text = "\(dimensions.width) x \(dimensions.height) x \(dimensions.depth), \(dimensions.weight)"
    }
    
    override func setHierarchy() {
        addSubviews(rulerImageView, dimensionsValueLabel)
    }
    
    override func setConstraint() {
        setTranslatesAutoresizingMaskIntoConstraintsOff(rulerImageView, dimensionsValueLabel)
        
        NSLayoutConstraint.activate([
            rulerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            rulerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rulerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rulerImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            dimensionsValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dimensionsValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dimensionsValueLabel.leadingAnchor.constraint(equalTo: self.rulerImageView.trailingAnchor, constant: 10)
        ])
    }
}
