import UIKit

final class BookDetailViewController: BaseViewController {
    // MARK: - Property
    private let book: Book
    private let bookDetail: BookDetail
    private let bookDetailViewModel: BookDetailViewModel
    
    // MARK: - UI
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
