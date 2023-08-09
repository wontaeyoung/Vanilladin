final class BookListViewController: BaseViewController {
    // MARK: - Dependency
    private let bookListViewModel: BookListViewModel
    
    // MARK: - Initializer
    init(
        bookListViewModel: BookListViewModel
    ) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
}
