import UIKit

extension UIViewController {
    func addChilds(_ childControllers: UIViewController...) {
        for childController in childControllers {
            self.addChild(childController)
        }
    }
}
