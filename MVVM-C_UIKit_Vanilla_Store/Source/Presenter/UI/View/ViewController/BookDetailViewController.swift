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
    
    private let paddingView: UIView = .init()
    
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
    
    private lazy var ratingView: RatingView = .init(ratingScore: bookDetail.ratingScore)
    
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
        bookImageView.image = book.coverImage
        titleLabel.attributedText = book.title.attributedTitleText
        authorPublisherLabel.text = book.author + " - " + book.publisher
        ratingView.ratingScore = bookDetail.ratingScore
    }
    
    override func setHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(paddingView)
        
        paddingView.addSubviews(
            bookImageView,
            titleLabel,
            authorPublisherLabel,
            priceLabel,
            ratingView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            scrollView,
            paddingView,
            bookImageView,
            titleLabel,
            authorPublisherLabel,
            priceLabel,
            ratingView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            paddingView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            paddingView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            paddingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paddingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: paddingView.topAnchor),
            bookImageView.centerXAnchor.constraint(equalTo: paddingView.centerXAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            authorPublisherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorPublisherLabel.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            authorPublisherLabel.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: authorPublisherLabel.bottomAnchor, constant: 10),
            ratingView.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
            ratingView.bottomAnchor.constraint(equalTo: paddingView.bottomAnchor)
        ])
    }
}
