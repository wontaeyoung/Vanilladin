import UIKit

final class SearchHistoryViewController: BaseViewController {
    
    // MARK: - Dependency
    private let searchHistoryViewModel: SearchHistoryViewModel
    var delegate: SearchHistoryViewDelegate?
    
    // MARK: - UI
    private(set) lazy var searchHistoryTableView: SearchHistoryTableView = .init()
    
    // MARK: - Initializer
    init(
        searchHistoryViewModel: SearchHistoryViewModel
    ) {
        self.searchHistoryViewModel = searchHistoryViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
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

extension SearchHistoryViewController: UITableViewDelegate {
    // Cell이 선택되지 않음
    func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
}
