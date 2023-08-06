import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    // MARK: - Property
    var delegate: CoordinatorDelegateProtocol? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    // MARK: - Initializer
    init(
        _ navigationController: UINavigationController,
        childCoordinators: [CoordinatorProtocol]
    )
    
    // MARK: - Method
    func start()
    func end()
    func push(_ viewController: BaseViewController)
    func pop()
    func dismissModal()
    func emptyOut()
    func handle(error: AppErrorProtocol)
}

extension CoordinatorProtocol {
    
    // MARK: - Method
    func end() {
        childCoordinators.removeAll()
        delegate?.coordinatorDidEnd(self)
    }
    
    func push(_ viewController: BaseViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func dismissModal() {
        navigationController.dismiss(animated: true)
    }
    
    func emptyOut() {
        navigationController.viewControllers.removeAll()
    }
    
    func handle(error: AppErrorProtocol) {
        
        let alertController: UIAlertController = .init(
            title: "오류 발생",
            message: error.errorDescription,
            preferredStyle: .alert
        )
        
        let okAction: UIAlertAction = .init(
            title: "확인",
            style: .default
        )
        
        alertController.addAction(okAction)
        
        self.navigationController
            .present(
                alertController,
                animated: true
            )
    }
}
