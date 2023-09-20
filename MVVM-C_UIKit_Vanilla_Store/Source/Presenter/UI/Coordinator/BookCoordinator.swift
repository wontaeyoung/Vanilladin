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
        presentBookListViewController()
    }
}

// MARK: 네비게이션 + 에러 핸들링
private extension BookCoordinator {
    func presentBookListViewController() {
        do {
            let searchBookViewController: SearchBookViewController = try makeInstance()
            
            push(searchBookViewController)
        } catch {
            handle(error: error)
        }
    }
    
    func makeInstance<T: DependencyContainable>() throws -> T {
        let instance: T = try DependencyContainer.shared.resolve()
        
        return instance
    }
}
