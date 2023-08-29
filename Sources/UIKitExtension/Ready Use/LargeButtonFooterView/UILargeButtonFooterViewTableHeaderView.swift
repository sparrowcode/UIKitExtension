import UIKit

open class UILargeButtonFooterViewTableHeaderView: UICommonView {
    
    public let contentView = UILargeButtonFooterView()
    
    open override func commonInit() {
        super.commonInit()
        addSubview(contentView)
        layoutMargins = .zero
        layoutMargins.top = Spaces.step
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setWidthAndFit(width: readableWidth)
        contentView.frame.origin.x = .zero
        contentView.frame.origin.y = layoutMargins.top
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutIfNeeded()
        return .init(width: superSize.width, height: contentView.frame.maxY + layoutMargins.bottom)
    }
}
