import UIKit

final class BookCoordinator: CoordinatorProtocol {
    // MARK: - Stored Property
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]
    
    // MARK: - Initializer
    init(
        _ navigationController: UINavigationController,
        childCoordinators: [CoordinatorProtocol] = []
    ) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    // MARK: - Method
    func start() {
        showSearchBook()
    }
}

// MARK: 네비게이션
extension BookCoordinator {
    @MainActor 
    func showSearchBook() {
        do {
            let container: DependencyContainer = .shared
            
            let searchViewModel: SearchBookViewModel = try container.resolve()
            let historyViewModel: SearchHistoryViewModel = try container.resolve()
            let searchBookViewController: SearchBookViewController = .init(
                searchBookViewModel: searchViewModel,
                searchHistoryViewModel: historyViewModel)
            searchViewModel.coordinator = self
            
            push(searchBookViewController)
        } catch {
            handle(error: error)
        }
    }
    
    func showSearchHistory(to searchViewController: SearchBookViewController) {
        do {
            let container: DependencyContainer = .shared
            
            let searchViewModel: SearchBookViewModel = try container.resolve()
            let historyViewModel: SearchHistoryViewModel = try container.resolve()
            let viewController: SearchHistoryViewController = .init(
                searchBookViewModel: searchViewModel,
                searchHistoryViewModel: historyViewModel)
            viewController.setDelegate(searchViewController)
            
            searchViewController.searchResultNavigationController.viewControllers = [viewController]
        } catch {
            handle(error: error)
        }
    }
    
    func showResult(searchResultNavigationController: UINavigationController) {
        do {
            let container: DependencyContainer = .shared
            
            let searchViewModel: SearchBookViewModel = try container.resolve()
            let bookListViewModel: BookListViewModel = try container.resolve()
            let viewController: BookListViewController = .init(
                searchBookViewModel: searchViewModel,
                bookListViewModel: bookListViewModel)
            bookListViewModel.coordinator = self
            
            searchResultNavigationController.pushViewController(viewController, animated: false)
        } catch {
            handle(error: error)
        }
    }
    
    @MainActor 
    func showBookDetail(
        book: Book,
        bookDetail: BookDetail
    ) {
        do {
            let viewModel: BookDetailViewModel = try DependencyContainer.shared.resolve()
            
            let viewController: BookDetailViewController = .init(
                book: book,
                bookDetail: bookDetail,
                bookDetailViewModel: viewModel)
            
            push(viewController)
        } catch {
            handle(error: error)
        }
    }
}
