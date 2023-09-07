import UIKit

final class BookListViewController: BaseViewController {
    // MARK: - Property
    private let bookListViewModel: BookListViewModel
    
    // MARK: - UI
    private(set) lazy var bookTableView: BookTableView = .init()
    private var loadingIndicator: UIActivityIndicatorView = .init(style: .large)
    
    // MARK: - Initializer
    init(bookListViewModel: BookListViewModel) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        bookListViewModel.setDataSourceDelegate(self)
        bookListViewModel.setTableViewDataSource(to: bookTableView)
    }
    
    override func setHierarchy() {
        view.addSubview(bookTableView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(bookTableView)
        
        bookTableView.setAutoLayoutAllEqual(to: view)
    }
}

extension BookListViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.bookTableView.reloadData()
        }
    }
}
