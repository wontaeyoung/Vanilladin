import UIKit

final class SearchBookViewController: BaseViewController {
    // MARK: - Property
    private let searchBookViewModel: SearchBookViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    private let searchResultContainerViewController: SearchResultContainerViewController
    
    // MARK: - UI
    private lazy var searchGuideText: UILabel = {
        let label: UILabel = .init()
        label.text = "찾고싶은 책의 이름을 검색해주세요!"
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Initializer
    init(
        searchBookViewModel: SearchBookViewModel,
        searchHistoryViewModel: SearchHistoryViewModel,
        searchResultContainerViewController: SearchResultContainerViewController
    ) {
        self.searchBookViewModel = searchBookViewModel
        self.searchHistoryViewModel = searchHistoryViewModel
        self.searchResultContainerViewController = searchResultContainerViewController
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        navigationItem.searchController = {
            let searchController: UISearchController = .init(searchResultsController: searchResultContainerViewController)
            
            let searchBar: UISearchBar = searchController.searchBar
            searchBar.placeholder = "Search Books"
            searchBar.delegate = self
            searchBar.autocapitalizationType = .none
            searchBar.autocorrectionType = .no
            searchBar.spellCheckingType = .no
            
            return searchController
        }()
        
        searchResultContainerViewController.setViewControllerDelegate(self)
    }
    
    override func setHierarchy() {
        view.addSubviews(searchGuideText)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchGuideText)
        
        NSLayoutConstraint.activate([
            searchGuideText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchGuideText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Delegate
extension SearchBookViewController: SearchHistoryViewDelegate {
    func submitKeyword(_ keyword: String) {
        guard let searchBar = navigationItem.searchController?.searchBar else { return }
        searchBar.text = keyword
        searchBar.resignFirstResponder()
        
        searchBarSearchButtonClicked(searchBar)
    }
}
        
extension SearchBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        Task {
            searchBookViewModel.saveSearchKeyword(keyword: searchText)
            await searchBookViewModel.fetchBooks()
            searchResultContainerViewController.showBookList()
            searchHistoryViewModel.saveKeyword(searchText)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultContainerViewController.showSearchHistory()
    }
}
