import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Method
    func setHierarchy() { }
    func setConstraint() { }
    func setAttribute() { }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setConstraint()
        setAttribute()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("NSCoding initializer")
    }
}
