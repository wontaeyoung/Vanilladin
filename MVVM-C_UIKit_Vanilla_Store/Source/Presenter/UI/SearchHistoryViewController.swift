import UIKit

final class SearchHistoryViewController: BaseViewController {
    // MARK: - Property
    private let searchHistoryViewModel: SearchHistoryViewModel
    private weak var delegate: SearchHistoryViewDelegate?
    
    // MARK: - UI
    private(set) lazy var searchHistoryTableView: SearchHistoryTableView = .init()
    
    // MARK: - Initializer
    init(searchHistoryViewModel: SearchHistoryViewModel) {
        self.searchHistoryViewModel = searchHistoryViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        searchHistoryViewModel.setDataSourceDelegate(self)
        searchHistoryViewModel.setTableViewDataSource(to: searchHistoryTableView)
        searchHistoryTableView.delegate = self
    }
    
    override func setHierarchy() {
        view.addSubview(searchHistoryTableView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchHistoryTableView)
        
        searchHistoryTableView.setAutoLayoutAllEqual(to: view)
    }
}

extension SearchHistoryViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.searchHistoryTableView.reloadData()
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
}

extension SearchHistoryViewController {
    func setDelegate(_ delegate: SearchHistoryViewDelegate) {
        self.delegate = delegate
    }
}
