#if canImport(UIKit) && (os(iOS))
import UIKit

open class UILargeHeaderView: UICommonView {
    
    // MARK: - Views
    
    public let titleLabel = UICommonLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold)
        $0.textColor = .label
    }
    
    public let button = UIDimmedButton().do {
        $0.applyDefaultAppearance(with: .tintedContent)
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .init(top: Spaces.default_double, left: .zero, bottom: 14, right: .zero)
        insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        addSubviews(titleLabel, button)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.layoutDynamicHeight(
            x: layoutMargins.left,
            y: layoutMargins.top,
            width: layoutWidth
        )
        button.sizeToFit()
        button.setMaxXToSuperviewRightMargin()
        button.center.y = titleLabel.center.y
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: titleLabel.frame.maxY + layoutMargins.bottom)
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
