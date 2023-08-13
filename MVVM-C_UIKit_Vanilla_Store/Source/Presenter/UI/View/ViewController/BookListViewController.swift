import UIKit

final class BookListViewController: BaseViewController {
    // MARK: - Dependency
    private let bookListViewModel: BookListViewModel
    
    // MARK: - UI
    private lazy var bookTableView: BookTableView = .init()
    
    // MARK: - Initializer
    init(
        bookListViewModel: BookListViewModel
    ) {
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

extension BookListViewController: DataSourceDelegateProtocol {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.bookTableView.reloadData()
        }
    }
}
