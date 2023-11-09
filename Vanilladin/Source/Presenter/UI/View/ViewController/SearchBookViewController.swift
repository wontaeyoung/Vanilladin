import UIKit

final class SearchBookViewController: BaseViewController {
    // MARK: - Property
    private let searchBookViewModel: SearchBookViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    
    // MARK: - UI
    private var searchGuideView: SearchGuideView = .init()
    var searchSubView: UIView = .init()
    
    private let searchBar: UISearchBar = {
        let searchBar: UISearchBar = .init()
        searchBar.placeholder = "ex) Vanilladin"
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        
        return searchBar
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
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    override func setHierarchy() {
        view.addSubviews(searchGuideView, searchSubView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(searchGuideView, searchSubView)
        
        searchGuideView.setAutoLayoutAllEqualToMarginGuide(to: view, option: .all)
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
            searchBookViewModel.showSearchView(type: .result(searchResultNavigationController))
            searchHistoryViewModel.saveKeyword(searchText)
        }
    }
}
