import UIKit

class BaseCollectionView: UICollectionView {
    // MARK: - Initializer
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.registerCells()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) BaseCollectionView")
    }
    
    // MARK: - Method
    func registerCells() { }
    func register(_ cellClass: UICollectionViewCell.Type) {
        let identifier: String = .init(describing: cellClass)
        
        self.register(cellClass.self, forCellWithReuseIdentifier: identifier)
    }
}
