import UIKit

final class SearchResultContainerViewController: BaseViewController {
    // MARK: - Property
    private let searchHistoryViewController: SearchHistoryViewController
    private let bookListViewController: BookListViewController
    
    // MARK: - Initializer
    init(
        searchHistoryViewController: SearchHistoryViewController,
        bookListViewController: BookListViewController
    ) {
        self.searchHistoryViewController = searchHistoryViewController
        self.bookListViewController = bookListViewController
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        addChilds(
            searchHistoryViewController,
            bookListViewController)
    }
    
    override func setHierarchy() {
        view.addSubviews(
            searchHistoryViewController.view,
            bookListViewController.view)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            searchHistoryViewController.view,
            bookListViewController.view)
        
        searchHistoryViewController.view.setAutoLayoutAllEqual(to: view)
//        bookListViewController.view.setAutoLayoutAllEqual(to: view)
        NSLayoutConstraint.activate([
            bookListViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            bookListViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bookListViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookListViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - Showing View
extension SearchResultContainerViewController {
    func showSearchHistory() {
        bookListViewController.view.isHidden = true
        searchHistoryViewController.view.isHidden = false
    }
    
    func showBookList() {
        searchHistoryViewController.view.isHidden = true
        bookListViewController.view.isHidden = false
    }
}

extension SearchResultContainerViewController {
    func setViewControllerDelegate(_ delegate: SearchHistoryViewDelegate) {
        searchHistoryViewController.setDelegate(delegate)
    }
}
