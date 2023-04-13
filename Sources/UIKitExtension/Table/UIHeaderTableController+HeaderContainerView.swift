import UIKit

extension UIHeaderTableController {
    
    open class HeaderContainerView: UICommonView {
        
        // MARK: - Public
        
        public let contentView: UIView
        
        // MARK: - Init
        
        public init(contentView: UIView) {
            self.contentView = contentView
            super.init()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func commonInit() {
            super.commonInit()
            insetsLayoutMarginsFromSafeArea = false
            layoutMargins = .zero
            addSubview(contentView)
        }
        
        // MARK: - Layout
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            contentView.setWidthAndFit(width: layoutWidth)
            contentView.frame.origin.x = layoutMargins.left
            contentView.frame.origin.y = layoutMargins.top
        }
        
        public override func sizeThatFits(_ size: CGSize) -> CGSize {
            frame.setWidth(size.width)
            layoutSubviews()
            //print(size.width, contentView.frame.maxY, layoutMargins.bottom)
            return .init(width: size.width, height: contentView.frame.maxY + layoutMargins.bottom)
        }
    }
}
