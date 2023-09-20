import UIKit

final class BookDetailViewController: BaseViewController {
    // MARK: - Property
    private let book: Book
    private let bookDetail: BookDetail
    
    // MARK: - UI
    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        
        return scrollView
    }()
    
    private let bookImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .boldSystemFont(ofSize: UIConstant.FontSize.title)
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let authorPublisherLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.description)
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.description)
        label.numberOfLines = .zero
        
        return label
    }()
    
    private lazy var ratingView: RatingView = .init()
    
    // MARK: - Initializer
    init(
        book: Book,
        bookDetail: BookDetail
    ) {
        self.book = book
        self.bookDetail = bookDetail
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        ratingView.ratingScore = bookDetail.ratingScore
        titleLabel.attributedText = book.title.attributedTitleText
        authorPublisherLabel.text = book.author + " - " + book.publisher
    }
    
    override func setHierarchy() {
        view.addSubviews(
            scrollView,
            bookImageView,
            titleLabel,
            authorPublisherLabel,
            priceLabel,
            ratingView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            scrollView,
            bookImageView,
            titleLabel,
            authorPublisherLabel,
            priceLabel,
            ratingView)
        
        scrollView.setAutoLayoutAllEqual(to: view)
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor),
            ratingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
