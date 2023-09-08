import UIKit

final class BookListViewController: BaseViewController {
    // MARK: - Property
    private let bookListViewModel: BookListViewModel
    
    // MARK: - UI
    private lazy var bookTableView: BookTableView = .init()
    private lazy var bookCollectionView: BookCollectionView = .init(layout: UICollectionViewFlowLayout())
    private var loadingIndicator: UIActivityIndicatorView = .init(style: .large)
    private let selectListTypeView: SelectListTypeView = .init()
    
    // MARK: - Initializer
    init(bookListViewModel: BookListViewModel) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        bookListViewModel.setDataSourceDelegate(self)
        bookListViewModel.setTableViewDataSource(to: bookTableView)
        bookListViewModel.setCollectionViewDataSource(to: bookCollectionView)
        
        guard
            let laytout = bookCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else { return }
        
        laytout.setAttribute(
            direction: .vertical,
            width: UIConstant.DeviceSize.width * 0.45,
            height: UIConstant.DeviceSize.width * 0.8,
            lineSpacing: 10,
            itemSpacing: 0,
            inset: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
        
        selectListTypeView.toggleAction = {
            self.bookListViewModel.toggleListType()
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(bookTableView, bookCollectionView, selectListTypeView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(bookTableView ,bookCollectionView, selectListTypeView)
        
        NSLayoutConstraint.activate([
            selectListTypeView.topAnchor.constraint(equalTo: view.topAnchor),
            selectListTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectListTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectListTypeView.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            bookTableView.topAnchor.constraint(equalTo: selectListTypeView.bottomAnchor),
            bookTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bookTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            bookCollectionView.topAnchor.constraint(equalTo: selectListTypeView.bottomAnchor),
            bookCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bookCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension BookListViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.bookCollectionView.reloadData()
            self.bookTableView.reloadData()
        }
    }
}
