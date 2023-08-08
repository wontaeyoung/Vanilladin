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

// MARK: 인스턴스 생성 및 에러 핸들링 + 네비게이션
private extension BookCoordinator {
    func presentBookListViewController() {
        let searchBookViewController: SearchBookViewController = makeInstance()
                    
        push(searchBookViewController)
    }
}

// MARK: 인스턴스 생성 및 에러 핸들링
extension BookCoordinator {
    func makeInstance<T: DependencyContainable>() -> T {
        do {
            let instance: T = try DependencyContainer.shared.resolve()
            
            return instance
        } catch {
            guard let error = error as? AppErrorProtocol else {
                print(#function, "에러 타입캐스팅 실패!")
            }
            
            handle(error: error)
        }
    }
}
