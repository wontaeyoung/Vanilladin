import UIKit

final class AppCoordinator: CoordinatorProtocol {
    // MARK: - Property
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
        pushBookListFlow()
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func coordinatorDidEnd(_ childCoordinator: CoordinatorProtocol) {
        self.navigationController.popToRootViewController(animated: true)
    }
}

private extension AppCoordinator {
    func pushBookListFlow() {
        self.emptyOut()
        
        let bookCoordinator: BookCoordinator = .init(self.navigationController)
        bookCoordinator.delegate = self
        self.childCoordinators.append(bookCoordinator)
        
        bookCoordinator.start()
    }
}
