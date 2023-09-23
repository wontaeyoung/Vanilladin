import UIKit

// MARK: - Configure UI
extension UIView {
    enum MarginGuideOption {
        case all
        case horizontal
        case vertical
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func setTranslatesAutoresizingMaskIntoConstraintsOff(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setAutoLayoutAllEqual(to view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setAutoLayoutAllEqualToMarginGuide(
        to view: UIView,
        option marginGuideOption: MarginGuideOption
    ) {
        switch marginGuideOption {
        case .all:
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
            
        case .horizontal:
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
            
        case .vertical:
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    func setPaddingAutoLayout(
        to view: UIView,
        padding: CGFloat = 0
    ) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func setPaddingAutoLayout(
        to view: UIView,
        horizontal: CGFloat = 0,
        vertical: CGFloat = 0
    ) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: vertical),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -vertical),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontal),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontal)
        ])
    }
}

// MARK: - Utility
extension UIView {
    @objc func handleTap() {
        self.endEditing(true)
    }
    
    func tapToEndEditing() {
        let backgroundTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        
        self.addGestureRecognizer(backgroundTapGesture)
    }
}
