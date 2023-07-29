import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: - Method
    func setHierarchy() { }
    func setConstraint() { }
    func setAttribute() { }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setHierarchy()
        setConstraint()
        setAttribute()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("NSCoding initializer")
    }
}

