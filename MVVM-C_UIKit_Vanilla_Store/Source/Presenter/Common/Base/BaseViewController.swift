import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setHierarchy()
        setConstraints()
        setAttributes()
    }
    
    func setHierarchy() { }
    func setConstraints() { }
    func setAttributes() { }
    
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
