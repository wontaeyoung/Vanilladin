import UIKit

final class BookListViewController: BaseViewController {

    // MARK: - Stored Property
    private let bookListViewModel: BookListViewModel
    private var text: UILabel = {
        let label: UILabel = .init()
        label.text = "찾고싶은 책의 이름을 검색해주세요!"
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Initializer
    init(
        bookListViewModel: BookListViewModel
    ) {
        self.bookListViewModel = bookListViewModel
        
        super.init()
    }
    
    // MARK: - Method
    override func setAttribute() {
        navigationItem.searchController = {
            let searchController: UISearchController = .init()
            let searchBar: UISearchBar = searchController.searchBar
            
            searchBar.placeholder = "Search Books"
            
            return searchController
        }()
    }
    
    override func setHierarchy() {
        view.addSubview(text)
    }
    
    override func setConstraint() {
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
