import UIKit

final class SearchKeywordCell: BaseTableViewCell {
    // MARK: - Property
    var keyword: String? {
        didSet {
            self.setAttribute()
        }
    }
    
    var deleteAction: (() -> Void)?
    
    // MARK: - UI
    private let paddingView: UIView = .init()
    
    private let keywordLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: UIConstant.FontSize.description)
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button: UIButton = .init(type: .system)
        button.setTitle("삭제", for: .normal)
        button.addTarget(
            SearchKeywordCell.self,
            action: #selector(deleteButtonDidTap),
            for: .touchUpInside
        )
        
        return button
    }()
}
