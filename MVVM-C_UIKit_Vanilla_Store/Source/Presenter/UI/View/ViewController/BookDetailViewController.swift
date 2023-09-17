import UIKit

final class BookDetailViewController: BaseViewController {
    // MARK: - Property
    private let bookDetail: BookDetail
    private let bookDetailViewModel: BookDetailViewModel
    // MARK: - UI
    // MARK: - Initializer
    init(
        bookDetail: BookDetail,
        bookDetailViewModel: BookDetailViewModel
    ) {
        self.bookDetail = bookDetail
        self.bookDetailViewModel = bookDetailViewModel
        
        super.init()
    }
    
    // MARK: - Method
}
