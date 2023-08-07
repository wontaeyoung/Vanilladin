import UIKit

final class BookSearchResultViewController: BaseViewController {
    private var bookListViewModel: BookListViewModel
    
    init(
        bookListViewModel: BookListViewModel
    ) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
}
