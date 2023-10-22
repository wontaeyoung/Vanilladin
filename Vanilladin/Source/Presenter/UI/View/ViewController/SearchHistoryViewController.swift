import UIKit

final class SearchHistoryViewController: BaseViewController {
    // MARK: - Property
    private let searchBookViewModel: SearchBookViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    private weak var delegate: SearchHistoryViewDelegate?
    
    // MARK: - UI
    private(set) lazy var searchHistoryTableView: SearchHistoryTableView = .init()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = .init()
        indicator.style = .large
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: - Initializer
    init(
        searchBookViewModel: SearchBookViewModel,
        searchHistoryViewModel: SearchHistoryViewModel
    ) {
        self.searchBookViewModel = searchBookViewModel
        self.searchHistoryViewModel = searchHistoryViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        searchHistoryViewModel.setDataSourceDelegate(self)
        searchHistoryViewModel.setTableViewDataSource(to: searchHistoryTableView)
        searchBookViewModel.setDelegate(self)
        searchHistoryTableView.delegate = self
    }
    
    override func setHierarchy() {
        view.addSubviews(searchHistoryTableView, loadingIndicator)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchHistoryTableView)
        
        searchHistoryTableView.setAutoLayoutAllEqual(to: view)
    }
}

// MARK: - Delegate
extension SearchHistoryViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.searchHistoryTableView.reloadData()
        }
    }
}

extension SearchHistoryViewController: LoadingIndicatorDelegate {
    func showIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
}

extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let keyword = searchHistoryViewModel.getKeyword(at: indexPath.row) else { return }
        
        delegate?.submitKeyword(keyword)
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return SearchHistoryHeaderView {
            self.searchHistoryViewModel.removeAllKeywords()
        }
    }
}

// MARK: - Dependency
extension SearchHistoryViewController {
    func setDelegate(_ delegate: SearchHistoryViewDelegate) {
        self.delegate = delegate
    }
}
