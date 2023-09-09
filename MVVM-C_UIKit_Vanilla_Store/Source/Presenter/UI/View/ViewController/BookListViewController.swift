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
        // DataSource, Delegate 설정
        bookListViewModel.setDataSourceDelegate(self)
        bookListViewModel.setTableViewDataSource(to: bookTableView)
        bookListViewModel.setCollectionViewDataSource(to: bookCollectionView)
        
        // CollectionView Grid 레이아웃 설정
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
        
        // List Style부터 시작하도록 설정
        bookCollectionView.isHidden = true
        
        
        // List Style Toggle에 대한 Action 전달
        selectListTypeView.toggleAction = {
            let currentType: BookListViewModel.ListType = self.bookListViewModel.toggleListType()
            
            switch currentType {
            case .table:
                self.showListView()
                
            case .collection:
                self.showGridView()
            }
        }
    }
    
    override func setHierarchy() {
        view.addSubviews(bookTableView, bookCollectionView, selectListTypeView)
    }
    
    override func setConstraint() {
        view.setTranslatesAutoresizingMaskIntoConstraintsOff(
            bookTableView,
            bookCollectionView,
            selectListTypeView)
        
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

// MARK: - Show List / Grid
extension BookListViewController {
    /// List 스크롤 초기화, Grid 숨기기
    func showListView() {
        bookTableView.contentOffset = .zero
        bookTableView.isHidden = false
        bookCollectionView.isHidden = true
    }
    
    /// Grid 스크롤 초기화, List 숨기기
    func showGridView() {
        bookCollectionView.contentOffset = .zero
        bookTableView.isHidden = true
        bookCollectionView.isHidden = false
    }
}

// MARK: - Delegate
extension BookListViewController: DataSourceDelegate {
    func entitiesDidUpdate() {
        DispatchQueue.main.async {
            self.bookTableView.reloadData()
            self.bookCollectionView.reloadData()
            
            switch self.bookListViewModel.listType {
            case .table:
                self.bookTableView.contentOffset = .zero

            case .collection:
                self.bookCollectionView.contentOffset = .zero
            }
        }
    }
}
