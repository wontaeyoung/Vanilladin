import UIKit

final class CommentView: BaseView {
    // MARK: - Property
    private let bookDetail: BookDetail
    
    // MARK: - UI
    private let commentImage: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: UIConstant.SFSymbol.textBubble)?
            .colored(with: .black)
        
        return imageView
    }()
    
    private let commentCountLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.description)
        label.numberOfLines = .zero
        
        return label
    }()
    
    // MARK: - Initializer
    init(bookDetail: BookDetail) {
        self.bookDetail = bookDetail
        
        super.init(frame: .zero)
    }
    
}
