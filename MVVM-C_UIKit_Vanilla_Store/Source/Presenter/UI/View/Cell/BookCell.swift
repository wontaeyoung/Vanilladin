import UIKit

final class BookCell: BaseTableViewCell {
    // MARK: - Dependency
    var book: Book? {
        didSet {
            self.setAttribute()
        }
    }
    
    // MARK: - UI
    private let bookImage: UIImageView = .init()
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        
        return label
    }()
    private let descriptionLabel: UILabel = .init()
    private let authorLabel: UILabel = .init()
    private let publisherLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    
    private lazy var infoStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            authorLabel,
            publisherLabel,
            priceLabel
        ])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - Initializer
    
    // MARK: - Method
    override func setAttribute() {
        bookImage.image = book?.coverImage
        titleLabel.text = book?.title
        descriptionLabel.text = book?.description
        authorLabel.text = book?.author
        publisherLabel.text = book?.publisher
        priceLabel.text = book?.priceSales.asPriceString
    }
    
}
