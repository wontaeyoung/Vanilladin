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
    @MainActor func showSearchBook() {
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
    
    @MainActor func showBookDetail(
        book: Book,
        bookDetail: BookDetail
    ) {
        let viewController: BookDetailViewController = .init(
            book: book,
            bookDetail: bookDetail)
        
        push(viewController)
    }
}
