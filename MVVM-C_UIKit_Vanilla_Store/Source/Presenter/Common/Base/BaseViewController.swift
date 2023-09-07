import UIKit

class BaseViewController: UIViewController, DependencyContainable {
  
  // MARK: - Method
  func setAttribute() { }
  func setHierarchy() { }
  func setConstraint() { }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    setAttribute()
    setHierarchy()
    setConstraint()
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
