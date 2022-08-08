#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public protocol UICommonInit {
    
    /**
     UIKitExtension: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride init. Using one function for configurate view.
     */
    func commonInit()
}

open class UICommonView: UIView, UICommonInit {
    
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonControl: UIControl, UICommonInit {
    
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonButton: UIButton, UICommonInit {
    
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
    
    // MARK: - Layout
    
    /**
     UIKitExtension: Inset between image and title.
     
     No need any additional processing layout.
     It work automatically in `layoutSubviews` method.
     */
    open var titleImageInset: CGFloat? = nil
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let inset = titleImageInset {
            if imageView?.image == nil {
                imageEdgeInsets.right = .zero
                titleEdgeInsets.left = .zero
            } else {
                if ltr {
                    imageEdgeInsets.right = inset
                    titleEdgeInsets.left = inset
                } else {
                    imageEdgeInsets.right = -inset
                    titleEdgeInsets.left = -inset
                }
            }
        }
    }
}

open class UICommonImageView: UIImageView, UICommonInit {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public init(image: UIImage?, contentMode: UIImageView.ContentMode) {
        super.init(image: image)
        self.contentMode = contentMode
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonLabel: UILabel, UICommonInit {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonSlider: UISlider, UICommonInit {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonTextField: UITextField, UICommonInit {
    
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

public class UICommonInitTextView: UITextView, UICommonInit {
    
    public init() {
        super.init(frame: .zero, textContainer: nil)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonCollectionView: UICollectionView, UICommonInit {
    
    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonCollectionViewCell: UICollectionViewCell, UICommonInit {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonTableView: UITableView, UICommonInit {
    
    public init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}

open class UICommonTableViewCell: UITableViewCell, UICommonInit {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {}
}
#endif
