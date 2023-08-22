import UIKit

final class SearchResultContainerViewController: BaseViewController {
    private let searchHistoryViewController: SearchHistoryViewController
    private let bookListViewController: BookListViewController
    
    init(
        searchHistoryViewController: SearchHistoryViewController,
        bookListViewController: BookListViewController
    ) {
        self.searchHistoryViewController = searchHistoryViewController
        self.bookListViewController = bookListViewController
        
        super.init()
    }
    
    override func setAttribute() {
        addChilds(searchHistoryViewController, bookListViewController)
    }
    
    override func setHierarchy() {
        view.addSubviews(
            searchHistoryViewController.view,
            bookListViewController.view
        )
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            searchHistoryViewController.view,
            bookListViewController.view
        )
        
        searchHistoryViewController.view.setAutoLayoutAllEqual(to: view)
        bookListViewController.view.setAutoLayoutAllEqual(to: view)
    }
}

// MARK: - Showing View
extension SearchResultContainerViewController {
    private func addChileViewController(_ child: BaseViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func removeChildViewController(_ child: BaseViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func showSearchHistory() {
        removeChildViewController(bookListViewController)
        addChileViewController(searchHistoryViewController)
    }
    
    func showBookList() {
        removeChildViewController(searchHistoryViewController)
        addChileViewController(bookListViewController)
    }
}
