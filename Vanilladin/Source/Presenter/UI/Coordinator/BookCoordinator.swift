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
            let searchBookViewController: SearchBookViewController = try DependencyContainer.shared.resolve()
            
            push(searchBookViewController)
        } catch {
            handle(error: error)
        }
    }
}
