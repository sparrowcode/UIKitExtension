import UIKit

open class UILargeButtonFooterView: UICommonView {
    
    public let button = UILargeActionButton().do {
        $0.applyDefaultAppearance(with: .tinted)
    }
    
    public let footerView = UIFooterView()
    
    // MARK: - Init
     
    open override func commonInit() {
        super.commonInit()
        addSubviews([button, footerView])
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        button.sizeToFit()
        button.frame.setWidth(frame.width)
        
        footerView.setWidthAndFit(width: button.frame.width)
        footerView.frame.origin.x = button.frame.origin.x
        footerView.frame.origin.y = button.frame.maxY
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: footerView.frame.maxY + layoutMargins.bottom)
    }
}
