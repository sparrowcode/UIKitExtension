#if canImport(UIKit) && (os(iOS))
import UIKit

open class UIFooterView: UICommonView {
    
    // MARK: - Views
    
    public let label = UICommonLabel().do {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = .zero
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .gray
        }
    }
    
    public override init() {
        super.init()
    }
    
    public init(text: String) {
        super.init()
        label.text = text
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .init(top: Spaces.default_half, left: 16, bottom: Spaces.default_half, right: .zero)
        addSubview(label)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        label.layoutDynamicHeight(x: layoutMargins.left, y: layoutMargins.top, width: layoutWidth)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: label.frame.maxY + layoutMargins.bottom)
    }
}
#endif
