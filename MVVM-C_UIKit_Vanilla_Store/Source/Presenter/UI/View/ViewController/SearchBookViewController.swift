import UIKit

final class SearchBookViewController: BaseViewController {

    // MARK: - Dependency
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

// MARK: - Interface
extension SearchBookViewController: SearchHistoryViewDelegate {
    func submitKeyword(_ keyword: String) {
        guard let searchBar = navigationItem.searchController?.searchBar else { return }
        searchBar.text = keyword
        searchBar.resignFirstResponder()
        
        searchBarSearchButtonClicked(searchBar)
    }
}
        
// MARK: - Delegate
extension SearchBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 키워드 저장
        guard let searchText: String = searchBar.text else { return }
        searchHistoryViewModel.saveKeyword(searchText)
        
        // 검색 내용으로 쿼리 요청
        Task {
            await searchBookViewModel.fetchBooks(keyword: searchText)
            searchResultContainerViewController.showBookList()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultContainerViewController.showSearchHistory()
    }
}
