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
    
    // MARK: - Method
    override func setAttribute() {
        keywordLabel.text = keyword
    }
    
    override func setHierarchy() {
        contentView.addSubview(paddingView)
        paddingView.addSubviews(keywordLabel, deleteButton)
    }
    
    override func setConstraint() {
        setTranslatesAutoresizingMaskIntoConstraintsOff(paddingView, keywordLabel, deleteButton)
        
        paddingView.setPaddingAutoLayout(to: contentView, padding: 20)
        
        NSLayoutConstraint.activate([
            keywordLabel.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant: 10),
            keywordLabel.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant: -10),
            keywordLabel.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor)
        ])
    }
    
    @objc private func deleteButtonDidTap() {
        deleteAction?()
    }
}
