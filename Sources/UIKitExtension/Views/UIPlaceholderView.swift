#if canImport(UIKit) && (os(iOS))
import UIKit

open class UIPlaceholderView: UICommonButton {
    
    // MARK: - Views
    
    public let iconImageView = UICommonImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    public let headerLabel = UICommonLabel().do {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
    }
    
    public let descriptionLabel = UICommonLabel().do {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular)
    }
    
    // MARK: - Init
    
    public override init() {
        super.init()
    }
    
    public init(icon: UIImage, title: String, subtitle: String) {
        super.init()
        iconImageView.image = icon.alwaysTemplate
        headerLabel.text = title
        descriptionLabel.text = subtitle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        tintColor = .tertiaryLabel
        backgroundColor = .clear
        iconImageView.tintColor = tintColor
        headerLabel.textColor = tintColor
        descriptionLabel.textColor = tintColor
        addSubviews(iconImageView, headerLabel, descriptionLabel)
    }
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    open func setVisible(_ state: Bool, animated: Bool) {
        let work = { [weak self] in
            guard let self = self else { return }
            self.alpha = state ? 1 : .zero
        }
        if animated {
            UIView.animate(withDuration: 0.45, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                work()
            }, completion: nil)
        } else {
            work()
        }
    }
    
    // MARK: - Layout
    
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        sizeToFit()
        let width = superview.readableWidth
        frame.setWidth(width)
        setXCenter()
        frame.origin.y = y
    }
    
    open func layoutCenter() {
        guard let superview = self.superview else { return }
        let width = superview.readableWidth
        setWidthAndFit(width: width)
        setXCenter()
        switch superview {
        case _ as UICollectionView:
            center.y = (superview.layoutHeight / 2) * 0.94
        case _ as UITableView:
            center.y = (superview.layoutHeight / 2) * 0.94
        default:
            center.y = (superview.frame.height / 2) * 0.94
        }
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.sizeToFit()
        iconImageView.setXCenter()
        iconImageView.frame.origin.y = layoutMargins.top
        headerLabel.layoutDynamicHeight(width: layoutWidth)
        headerLabel.frame.origin.y = iconImageView.frame.maxY + 12
        headerLabel.setXCenter()
        descriptionLabel.layoutDynamicHeight(width: layoutWidth)
        descriptionLabel.frame.origin.y = headerLabel.frame.maxY + 4
        descriptionLabel.setXCenter()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: descriptionLabel.frame.maxY + layoutMargins.bottom)
    }
}
#endif
