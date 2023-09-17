import UIKit

final class BookDetailViewController: BaseViewController {
    // MARK: - Property
    private let book: Book
    private let bookDetail: BookDetail
    private let bookDetailViewModel: BookDetailViewModel
    
    // MARK: - UI
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
    
    // MARK: - Initializer
    init(
        book: Book,
        bookDetail: BookDetail,
        bookDetailViewModel: BookDetailViewModel
    ) {
        self.book = book
        self.bookDetail = bookDetail
        self.bookDetailViewModel = bookDetailViewModel
        
        super.init()
    }
    
    // MARK: - Method
}
