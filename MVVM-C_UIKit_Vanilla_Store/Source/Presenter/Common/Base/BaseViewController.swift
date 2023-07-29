import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Method
    func setHierarchy() { }
    func setConstraints() { }
    func setAttributes() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setHierarchy()
        setConstraints()
        setAttributes()
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
