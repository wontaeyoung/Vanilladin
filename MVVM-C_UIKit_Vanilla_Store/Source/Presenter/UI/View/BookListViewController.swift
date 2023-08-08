final class BookListViewController: BaseViewController {
    // MARK: - Stored Property
    private let bookListViewModel: BookListViewModel
    
    // MARK: - Initializer
    init(
        bookListViewModel: BookListViewModel
    ) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
}
