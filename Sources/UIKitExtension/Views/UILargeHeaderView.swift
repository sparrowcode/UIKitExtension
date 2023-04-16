#if canImport(UIKit) && (os(iOS))
import UIKit
import SwiftBoost

open class UILargeHeaderView: UICommonView {
    
    // MARK: - Views
    
    public let button = UIDimmedButton().do {
        $0.applyDefaultAppearance(with: .init(content: .label, background: .clear))
        $0.higlightStyle = .content
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
    }
    
    public var showChevron: Bool = false {
        didSet {
            if showChevron {
                var image = UIImage(systemName: "chevron.right")
                let fontConfig = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, weight: .bold))
                image = image?.applyingSymbolConfiguration(fontConfig)
                image = image?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
                button.setImage(image)
            } else {
                button.setImage(nil)
            }
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        layoutMargins = .init(top: Spaces.default_double, left: .zero, bottom: 14, right: .zero)
        addSubviews(button)
        
        showChevron = true
    }
    
    // MARK: - Layout
    
    public func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        setWidthAndFit(width: superview.layoutWidth)
        frame.origin = .init(x: superview.layoutMargins.left, y: y)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = Spaces.step
        button.contentEdgeInsets.left = spacing
        button.contentEdgeInsets.right = spacing
        
        button.sizeToFit()
        
        button.frame.origin.y = layoutMargins.top
        if ltr {
            button.frame.origin.x = layoutMargins.left
        } else {
            button.frame.setMaxX(frame.width - layoutMargins.right)
        }
        
        let buttonWidth = button.frame.width
        let imageWidth = button.imageView?.frame.width ?? .zero
        
        
        button.imageEdgeInsets = UIEdgeInsets(
            top: 1,
            left: buttonWidth - spacing - imageWidth,
            bottom: -1,
            right: -spacing
        )
        
        button.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -(imageWidth + spacing + spacing + imageWidth),
            bottom: 0,
            right: 0
        )
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: button.frame.maxY + layoutMargins.bottom)
    }
    
    // MARK: - Private
    
    var diffableButtonAction: (()->Void)? = nil {
        didSet {
            if let _ = diffableButtonAction {
                self.button.addTarget(self, action: #selector(self.diffableButtonTargetAction), for: .touchUpInside)
            } else {
                self.button.removeTargetsAndActions()
            }
        }
    }
    
    @objc func diffableButtonTargetAction() {
        self.diffableButtonAction?()
    }
}
#endif
