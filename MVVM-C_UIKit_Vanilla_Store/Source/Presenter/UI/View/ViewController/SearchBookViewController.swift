import UIKit

final class SearchBookViewController: BaseViewController {

    // MARK: - Dependency
    private let searchBookViewModel: SearchBookViewModel
    private let bookListViewController: BookListViewController
    
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
        bookListViewController: BookListViewController
    ) {
        self.searchBookViewModel = searchBookViewModel
        self.bookListViewController = bookListViewController
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        navigationItem.searchController = {
            let searchController: UISearchController = .init(searchResultsController: bookListViewController)
            let searchBar: UISearchBar = searchController.searchBar
            
            searchBar.placeholder = "Search Books"
            searchBar.delegate = self
            searchBar.autocapitalizationType = .none
            searchBar.autocorrectionType = .no
            searchBar.spellCheckingType = .no
            
            return searchController
        }()
    }
    
    override func setHierarchy() {
        view.addSubview(searchGuideText)
    }
    
    override func setConstraint() {
        searchGuideText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchGuideText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchGuideText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension SearchBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            await searchBookViewModel.fetchBooks(keyword: searchBar.text ?? "")
        }
    }
        searchResultContainerViewController.showSearchHistory()
    }
}
