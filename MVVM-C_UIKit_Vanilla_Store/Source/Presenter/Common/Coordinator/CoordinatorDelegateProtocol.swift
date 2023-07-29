import UIKit

protocol CoordinatorDelegateProtocol: AnyObject {
    func coordinatorDidEnd(_ childCoordinator: CoordinatorProtocol)
}
