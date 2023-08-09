import UIKit

class BaseTableView: UITableView {
    
    // MARK: - Method
    func register() { }
    
    // MARK: - Initializer
    init() {
        super.init(
            frame: .zero,
            style: .plain
        )
        
        self.register()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("NSCoding initializer")
    }
}
