#if canImport(UIKit) && (os(iOS))
import UIKit
import SparrowKit

@available(iOS 13.0, *)
open class NativeProfileHeaderView: SPView {
    
    // MARK: - Public
    
    public let avatarView = NativeAvatarView().do {
        $0.avatarAppearance = .placeholder
        $0.isEditable = true
    }
    
    public let nameLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold, addPoints: 2)
        $0.textColor = .label
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.text = .space
    }
    
    // Add tap to clipboard
    public let emailButton = SPDimmedButton().do {
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular, addPoints: -2)
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
        $0.titleLabel?.minimumScaleFactor = 0.5
        $0.setTitle(.space)
        $0.titleImageInset = 2
    }
    
    // MARK: - Private
    
    private var extendView = SPView()
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        backgroundColor = .systemBackground
        extendView.backgroundColor = backgroundColor
        addSubviews([extendView, avatarView, nameLabel, emailButton])
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        extendView.frame = .init(x: .zero, maxY: .zero, width: frame.width, height: 1000)
        
        avatarView.sizeToFit()
        avatarView.setXCenter()
        avatarView.frame.origin.y = layoutMargins.top
        
        nameLabel.layoutDynamicHeight(width: layoutWidth)
        nameLabel.setXCenter()
        nameLabel.frame.origin.y = avatarView.frame.maxY + 12
        
        emailButton.sizeToFit()
        emailButton.frame.setWidth(nameLabel.frame.width)
        emailButton.setXCenter()
        emailButton.frame.origin.y = nameLabel.frame.maxY + 2
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: frame.width, height: emailButton.frame.maxY + layoutMargins.bottom)
    }
}
#endif
