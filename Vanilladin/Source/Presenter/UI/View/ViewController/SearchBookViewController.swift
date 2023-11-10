import UIKit

final class SearchBookViewController: BaseViewController {
    // MARK: - Property
    private let searchBookViewModel: SearchBookViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    private var hasSearchGuideShown: Bool = false
    
    // MARK: - UI
    private var searchGuideView: SearchGuideView = .init()
    
    private(set) var searchResultNavigationController: UINavigationController = {
        let navigationController: UINavigationController = .init()
        navigationController.view.backgroundColor = .white
        
        return navigationController
    }()
    
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
        searchResultNavigationController.navigationBar.isHidden = true
    }
    
    override func setHierarchy() {
        view.addSubview(searchResultNavigationController.view)
        searchResultNavigationController.view.addSubview(searchGuideView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            searchResultNavigationController.view,
            searchGuideView)

        searchResultNavigationController.view.setAutoLayoutAllEqualToSafeArea(to: view)
        
        searchGuideView.setAutoLayoutAllEqual(to: searchResultNavigationController.view)
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
        searchBar.resignFirstResponder()
        searchBookAndShowResult(searchText: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if hasSearchGuideShown {
            searchResultNavigationController.popViewController(animated: false)
        } else {
            hideSearchGuide()
            searchBookViewModel.showSearchView(type: .keyword(self))
        }
    }
}

// MARK: - Private
private extension SearchBookViewController {
    func hideSearchGuide() {
        hasSearchGuideShown = true
        searchGuideView.removeFromSuperview()
    }
    
    func searchBookAndShowResult(searchText: String) {
        Task {
            await searchBookViewModel.requestBooks(type: .new(keyword: searchText))
            searchBookViewModel.showSearchView(type: .result(searchResultNavigationController))
            searchHistoryViewModel.saveKeyword(searchText)
        }
    }
}
