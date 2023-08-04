import UIKit

final class BookListViewController: BaseViewController {

    // MARK: - Stored Property
    private let bookListViewModel: BookListViewModel
    private var text: UILabel = {
        let label: UILabel = .init()
        label.text = "기본 텍스트"
        label.textColor = .blue
        
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
    override func setHierarchy() {
        view.addSubview(text)
    }
    
    override func setConstraint() {
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.widthAnchor.constraint(equalToConstant: 100),
            text.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
