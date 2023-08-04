import UIKit

final class AppCoordinator: CoordinatorProtocol, CoordinatorDelegateProtocol {
    
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
        
    }
}

extension AppCoordinator {
    
    func coordinatorDidEnd(_ childCoordinator: CoordinatorProtocol) {
        self.navigationController.popToRootViewController(animated: true)
    }
}
