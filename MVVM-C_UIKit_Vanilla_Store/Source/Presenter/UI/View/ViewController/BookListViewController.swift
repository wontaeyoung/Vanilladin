import UIKit

final class BookListViewController: BaseViewController {
    // MARK: - Property
    private let bookListViewModel: BookListViewModel
    
    // MARK: - UI
    private lazy var bookTableView: BookTableView = .init()
    private lazy var bookCollectionView: BookCollectionView = .init(layout: UICollectionViewFlowLayout())
    private var loadingIndicator: UIActivityIndicatorView = .init(style: .large)
    
    // MARK: - Initializer
    init(bookListViewModel: BookListViewModel) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        bookListViewModel.setDataSourceDelegate(self)
        bookListViewModel.setTableViewDataSource(to: bookTableView)
        
        guard let laytout = bookCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        laytout.setAttribute(
            direction: .vertical,
            width: UIConstant.DeviceSize.width * 0.45,
            height: UIConstant.DeviceSize.width,
            lineSpacing: 20,
            itemSpacing: 20,
            inset: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
    }
    
    override func setHierarchy() {
        view.addSubviews(bookTableView, bookCollectionView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(bookTableView, bookCollectionView)
        
        bookTableView.setAutoLayoutAllEqual(to: view)
        bookCollectionView.setAutoLayoutAllEqual(to: view)
    }
}

extension BookListViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.bookTableView.reloadData()
        }
    }
}
