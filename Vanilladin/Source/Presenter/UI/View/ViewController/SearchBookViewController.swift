import UIKit

final class SearchBookViewController: BaseViewController {
    // MARK: - Property
    private let searchBookViewModel: SearchBookViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    private let searchResultContainerViewController: SearchResultContainerViewController
    
    // MARK: - UI
    private let searchBar: UISearchBar = {
        let searchBar: UISearchBar = .init()
        searchBar.placeholder = "Search Book"
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        
        return searchBar
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
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchResultContainerViewController.setViewControllerDelegate(self)
    }
    
    override func setHierarchy() {
        view.addSubviews(searchGuideImageView, searchGuideText)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchGuideImageView, searchGuideText)
        
        NSLayoutConstraint.activate([
            searchGuideImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchGuideImageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: -50),
            searchGuideImageView.widthAnchor.constraint(equalToConstant: 200),
            searchGuideImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            searchGuideText.topAnchor.constraint(
                equalTo: searchGuideImageView.bottomAnchor,
                constant: 50),
            searchGuideText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - Delegate
extension SearchBookViewController: SearchHistoryViewDelegate {
    func submitKeyword(_ keyword: String) {
        searchBar.text = keyword
        searchBar.resignFirstResponder()
        
        searchBarSearchButtonClicked(searchBar)
    }
}
        
extension SearchBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        // 검색어 업데이트 -> 기존 Book 배열 초기화 -> 검색 페이지 초기화 -> Book 데이터 요청 -> Book List 화면으로 전환 -> 최근 검색어 저장
        Task {
            await searchBookViewModel.requestBooks(type: .new(keyword: searchText))
            searchResultContainerViewController.showBookList()
            searchHistoryViewModel.saveKeyword(searchText)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultContainerViewController.showSearchHistory()
    }
}
