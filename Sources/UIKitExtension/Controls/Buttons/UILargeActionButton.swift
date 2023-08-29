#if canImport(UIKit) && (os(iOS))
import UIKit

/**
 UIKitExtension: Large action button.
 Usually using at bottom of screen.
 */
open class UILargeActionButton: UIDimmedButton {
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, addPoints: 1)
        titleLabel?.numberOfLines = 1
        titleImageInset = 6
        // before was 12, 14 looks little better
        contentEdgeInsets = .init(horizontal: 10, vertical: 14)
        roundCorners(curve: .continuous, radius: Appearance.Corners.readable_area)
    }
    
    // MARK: - Layout
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        sizeToFit()
        let width = superview.readableWidth
        frame.setWidth(width)
        setXCenter()
        frame.origin.y = y
    }
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(maxY: CGFloat) {
        guard let superview = self.superview else { return }
        sizeToFit()
        let width = superview.readableWidth
        frame.setWidth(width)
        setXCenter()
        frame.setMaxY(maxY)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        let width = superSize.width
        
        let height = superSize.height
        /* Disabled image correction becouse
         returned other values and its confused lauout system.
         For now disabled.
         
        // When set image, height may change.
        // It's allow save height of button.
        if let titleLabel = titleLabel, let imageView = imageView, let _ = imageView.image {
            if titleLabel.frame.height > .zero && imageView.frame.height > .zero {
                let imageCorrection = imageView.frame.height - titleLabel.frame.height
                height -= imageCorrection
            }
        }*/
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Wrappers
    
    public static var defaultCornerRadius: CGFloat {
        let button = UILargeActionButton()
        return button.layer.cornerRadius
    }
    
    public static var defaultHeight: CGFloat {
        let button = UILargeActionButton()
        button.setTitle(.space)
        button.sizeToFit()
        return button.frame.height
    }
}
#endif
