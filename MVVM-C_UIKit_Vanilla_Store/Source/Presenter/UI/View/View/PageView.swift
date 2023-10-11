import UIKit

final class PageView: BaseView {
    // MARK: - Property
    private let page: Int
    
    // MARK: - UI
    private let pageImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: UIConstant.SFSymbol.bookPages)?
            .colored(with: .black)
        
        return imageView
    }()
    
    private let pageValueLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.title)
        label.numberOfLines = .zero
        
        return label
    }()
    
    // MARK: - Initializer
    init(page: Int) {
        self.page = page
        
        super.init(frame: .zero)
    }
    
    // MARK: - Method
    
}
