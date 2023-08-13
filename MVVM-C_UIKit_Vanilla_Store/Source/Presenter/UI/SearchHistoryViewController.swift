final class SearchHistoryViewController: BaseViewController {
    
    // MARK: - Dependency
    private let searchHistoryViewModel: SearchHistoryViewModel
    
    // MARK: - UI
    private lazy var searchHistoryTableView: SearchHistoryTableView = .init()
    
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
    }
    
    override func setHierarchy() {
        view.addSubview(searchHistoryTableView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchHistoryTableView)
        
        searchHistoryTableView.setAutoLayoutAllEqual(to: view)
    }
}
