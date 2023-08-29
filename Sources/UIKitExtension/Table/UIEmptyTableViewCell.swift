#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class UIEmptyTableViewCell: UICommonTableViewCell {
    
    // MARK: - Data
    
    open var verticalMargins: Margins = .medium {
        didSet {
            contentView.layoutMargins.top = self.verticalMargins.value
            contentView.layoutMargins.bottom = self.verticalMargins.value
        }
    }
    
    // MARK: - Views
    
    public let placeholderView = UIPlaceholderView().do {
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        selectionStyle = .none
        contentView.addSubview(placeholderView)
        updateBackgroundColorByParent()
    }
    
    // MARK: - Lifecycle
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateBackgroundColorByParent()
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderView.frame.origin.y = contentView.layoutMargins.top
        placeholderView.setWidthAndFit(width: contentView.layoutWidth)
        placeholderView.setXCenter()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        let calculatedHeight = placeholderView.frame.maxY + contentView.layoutMargins.bottom
        let bottomInset = calculatedHeight * (1 - 0.94)
        return .init(width: superSize.width, height: calculatedHeight + bottomInset)
    }
    
    // MARK: - Actions
    
    private func updateBackgroundColorByParent() {
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor.systemDownedGroupedBackground
        }
    }
    
    // MARK: - Models
    
    public enum Margins {
        
        case small
        case medium
        case large
        
        var value: CGFloat {
            switch self {
            case .small: return Spaces.default
            case .medium: return Spaces.default * 2
            case .large: return Spaces.default * 3
            }
        }
    }
}
#endif
