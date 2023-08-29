import UIKit

open class UILargeButtonFooterViewСollectionHeaderView: UICommonCollectionReusableView {
    
    public let contentView = UILargeButtonFooterView()
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        insetsLayoutMarginsFromSafeArea = false
        addSubview(contentView)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        contentView.button.removeTargetsAndActions()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setWidthAndFit(width: layoutWidth)
        contentView.frame.origin = .init(x: layoutMargins.left, y: layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: contentView.frame.maxY + layoutMargins.bottom)
    }
}
