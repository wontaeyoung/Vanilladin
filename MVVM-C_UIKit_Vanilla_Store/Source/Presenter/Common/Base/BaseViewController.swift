import UIKit

class BaseViewController: UIViewController, DependencyContainable {
    
    // MARK: - Method
    func setHierarchy() { }
    func setConstraint() { }
    func setAttribute() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setHierarchy()
        setConstraint()
        setAttribute()
    }
    
    // MARK: - Initializer
    init() {
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("NSCoding initializer")
    }
}
