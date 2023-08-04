import UIKit

final class BookCoordinator: CoordinatorProtocol {
    
    // MARK: - Stored Property
    weak var delegate: CoordinatorDelegateProtocol?
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
        presentBookListViewController()
    }
}

private extension BookCoordinator {
    func presentBookListViewController() {
        do {
            let bookListViewController: BookListViewController = try DependencyContainer.shared.resolve()
            push(bookListViewController)
        } catch {
            
        }
    }
}
