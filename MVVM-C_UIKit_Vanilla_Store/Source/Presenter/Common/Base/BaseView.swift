import UIKit

class BaseView: UIView {

    // MARK: - Method
    func setHierarchy() { }
    func setConstraints() { }
    func setAttributes() { }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setHierarchy()
        setConstraints()
        setAttributes()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("NSCoding initializer")
    }
}

