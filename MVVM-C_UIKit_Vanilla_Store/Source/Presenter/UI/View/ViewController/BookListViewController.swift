import UIKit

final class BookListViewController: BaseViewController {
    // MARK: - Dependency
    private let bookListViewModel: BookListViewModel
    
    private lazy var bookTableView: BookTableView = .init()
    
    // MARK: - Initializer
    init(
        bookListViewModel: BookListViewModel
    ) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
    
    override func setAttribute() {
        bookTableView.delegate = self
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

extension BookListViewController: UITableViewDelegate {
    
}

extension BookListViewController: DataSourceDelegateProtocol {
    func entitiesDidUpdate() {
        bookTableView.reloadData()
    }
}
