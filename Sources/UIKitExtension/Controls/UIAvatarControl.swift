
#if canImport(UIKit) && (os(iOS))
import UIKit

/*
 // edit buttons
 open var indicatorAddImage = UIImage.system("plus", font: .preferredFont(forTextStyle: .title3, weight: .bold)) {
     didSet {
         updateEditAppearance()
     }
 }
 
 open var indicatorAddColorise = UIDimmedButton.Colorise.init(content: .white, background: .systemGreen) {
     didSet {
         updateEditAppearance()
     }
 }
 
 open var indicatorEditImage = UIImage.system("pencil", font: .preferredFont(forTextStyle: .title3, weight: .bold)) {
     didSet {
         updateEditAppearance()
     }
 }
 
 open var indicatorEditColorise = UIDimmedButton.Colorise.init(content: .white, background: .systemBlue) {
     didSet {
         updateEditAppearance()
     }
 }
 */

open class UIAvatarControl: UICommonControl {
    
    // MARK: - Views
    
    public let activityIndicatorView = UIActivityIndicatorView().do {
        $0.stopAnimating()
    }
    
    public let avatarView = UICommonImageView().do {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    public let placeholderView = UICommonImageView().do {
        $0.image = UIImage.system("person.crop.circle.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .init(light: .systemGray3, dark: .systemGray2)
    }
    
    public let indicatorButton = UIDimmedButton().do {
        $0.contentEdgeInsets = .init(side: 4)
    }
    
    // MARK: - Public
    
    open var hasAvatar: Bool {
        switch avatarAppearance {
        case .avatar(_): return true
        default: return false
        }
    }
    
    open var avatarAppearance: AvatarAppearance = .placeholder {
        didSet {
            updateAvatarAppearance()
            updateEditAppearance()
        }
    }

    open var isEditable: Bool = false {
        didSet {
            updateEditAppearance()
        }
    }
    
    @objc func didTapAction(sender: UITapGestureRecognizer) {
        self.sendActions(for: .touchUpInside)
    }
    
    open override var isHighlighted: Bool {
        didSet {
            placeholderView.alpha = isHighlighted ? 0.8 : 1
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(placeholderView)
        addSubview(avatarView)
        addSubview(activityIndicatorView)
        
        updateAvatarAppearance()
        updateEditAppearance()
        
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(didTapAction(sender: )))
        
        addSubview(indicatorButton)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderView.setEqualSuperviewMarginsWithFrames()
        avatarView.setEqualSuperviewMarginsWithFrames()
        
        indicatorButton.sizeToFit()
        indicatorButton.roundMinimumSide()
        let sqrt2 = CGFloat(sqrt(2))
        if rtl {
            let indicatorCenter = ((avatarView.frame.width * (sqrt2 + 1)) / (2 * sqrt2)) * 1.02
            indicatorButton.center = .init(x: frame.width - indicatorCenter, y: indicatorCenter)
        } else {
            let indicatorCenter = ((avatarView.frame.width * (sqrt2 + 1)) / (2 * sqrt2)) * 1.02
            indicatorButton.center = .init(x: indicatorCenter, y: indicatorCenter)
        }
        
        activityIndicatorView.setToCenter()
    }
    
    // MARK: - Internal
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    internal func updateAvatarAppearance() {
        switch avatarAppearance {
        case .loading:
            activityIndicatorView.startAnimating()
            avatarView.isHidden = true
            placeholderView.isHidden = true
        case .placeholder:
            activityIndicatorView.stopAnimating()
            avatarView.isHidden = true
            placeholderView.isHidden = false
        case .avatar(let image):
            activityIndicatorView.stopAnimating()
            avatarView.isHidden = false
            avatarView.image = image
            placeholderView.isHidden = true
        }
    }
    
    internal func updateEditAppearance() {
        if isEditable {
            switch avatarAppearance {
            case .loading:
                indicatorButton.isHidden = true
            case .placeholder:
                indicatorButton.isHidden = false
                //indicatorButton.setImage(indicatorAddImage)
                //indicatorButton.applyDefaultAppearance(with: indicatorAddColorise)
            case .avatar(_):
                indicatorButton.isHidden = false
                //indicatorButton.setImage(indicatorEditImage)
                //indicatorButton.applyDefaultAppearance(with: indicatorEditColorise)
            }
        } else {
            indicatorButton.isHidden = true
        }
        
        [placeholderView, avatarView, indicatorButton].forEach({ $0.isUserInteractionEnabled = isEditable })
    }
    
    // MARK: - Models
    
    public enum AvatarAppearance {
        
        case loading
        case placeholder
        case avatar(_ image: UIImage)
    }
    
    public enum EditAppearance {
        
        case none
        case edit
        case add
    }
}

/*
/**
 NativeUIKit: Native avatar view.
 
 Using SFSymbols for content.
 You  shoud update avatar by set `avatarAppearance` to valid state.
 For change colors or content check images and colorises properties.
 For change show edit button set `isEditable` to true.
 */
#warning("todo redo it")
@available(iOS 13, *)
open class NativeAvatarView22: SPView {
    
    // MARK: - Views
    
    public lazy var activityIndicatorView = UIActivityIndicatorView().do {
        $0.stopAnimating()
    }
    
    public lazy var avatarButton = SPButton().do {
        $0.imageView?.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    public lazy var placeholderButton = SPButton().do {
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(placeholderImage.alwaysTemplate)
        $0.tintColor = .init(light: .systemGray3, dark: .systemGray2)
    }
    
    public lazy var indicatorButton = SPDimmedButton().do {
        $0.contentEdgeInsets = .init(side: 4)
    }
    
    // MARK: - Data
    
    /**
     NativeUIKit: Indicate if current state has avatar.
     */
    open var hasAvatar: Bool {
        switch avatarAppearance {
        case .avatar(_): return true
        default: return false
        }
    }
    
    /**
     NativeUIKit: Appearance of avatar button. Can be placeholder or with content.
     State loading show loading indicator and hide all other views.
     */
    open var avatarAppearance: AvatarAppearance = .placeholder {
        didSet {
            updateAvatarAppearance()
            updateEditAppearance()
        }
    }
    
    /**
     NativeUIKit: Hidden or visible edit button.
     */
    open var isEditable: Bool = false {
        didSet {
            updateEditAppearance()
        }
    }
    
    open var placeholderImage = generatePlaceholderImage(fontSize: 80, fontWeight: .medium) {
        didSet {
            placeholderButton.setImage(placeholderImage)
        }
    }
    
    open var placeholderColorise = SPDimmedButton.Colorise.init(content: .init(light: .systemGray3, dark: .systemGray2), background: .clear) {
        didSet {
            //placeholderButton.applyDefaultAppearance(with: placeholderColorise)
        }
    }
    
    open var indicatorAddImage = UIImage.system("plus", font: .preferredFont(forTextStyle: .title3, weight: .bold)) {
        didSet {
            updateEditAppearance()
        }
    }
    
    open var indicatorAddColorise = SPDimmedButton.Colorise.init(content: .white, background: .systemGreen) {
        didSet {
            updateEditAppearance()
        }
    }
    
    open var indicatorEditImage = UIImage.system("pencil", font: .preferredFont(forTextStyle: .title3, weight: .bold)) {
        didSet {
            updateEditAppearance()
        }
    }
    
    open var indicatorEditColorise = SPDimmedButton.Colorise.init(content: .white, background: .systemBlue) {
        didSet {
            updateEditAppearance()
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(placeholderButton)
        addSubview(avatarButton)
        addSubview(indicatorButton)
        addSubview(activityIndicatorView)
        updateAvatarAppearance()
        updateEditAppearance()
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderButton.frame = .init(side: layoutWidth)
        placeholderButton.frame.origin.y = layoutMargins.top
        placeholderButton.center.x = frame.width / 2
        
        let avatarSideSize = min(placeholderButton.frame.width, placeholderButton.frame.height) * 0.93
        avatarButton.frame = .init(side: avatarSideSize)
        avatarButton.center = placeholderButton.center
        avatarButton.roundMinimumSide()
        indicatorButton.sizeToFit()
        indicatorButton.roundMinimumSide()
        let sqrt2 = CGFloat(sqrt(2))
        
        
        if rtl {
            let indicatorCenter = ((avatarButton.frame.width * (sqrt2 + 1)) / (2 * sqrt2)) * 1.02
            indicatorButton.center = .init(x: frame.width - indicatorCenter, y: indicatorCenter)
        } else {
            let indicatorCenter = ((avatarButton.frame.width * (sqrt2 + 1)) / (2 * sqrt2)) * 1.02
            indicatorButton.center = .init(x: indicatorCenter, y: indicatorCenter)
        }
        
        activityIndicatorView.center = placeholderButton.center
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        placeholderButton.sizeToFit()
        frame.setWidth(placeholderButton.frame.width + layoutMargins.left + layoutMargins.right)
        layoutSubviews()
        if isEditable {
            return .init(
                width: max(placeholderButton.frame.maxX, indicatorButton.frame.maxX) + layoutMargins.bottom,
                height: max(placeholderButton.frame.maxY, indicatorButton.frame.maxY) + layoutMargins.bottom
            )
        } else {
            return .init(
                width: placeholderButton.frame.maxX + layoutMargins.bottom,
                height: placeholderButton.frame.maxY + layoutMargins.bottom
            )
        }
    }
    
    // MARK: - Public
    
    static public func generatePlaceholderImage(fontSize: CGFloat, fontWeight: UIFont.Weight) -> UIImage {
        return UIImage.system("person.crop.circle.fill", font: .systemFont(ofSize: fontSize, weight: fontWeight))
    }
    
    // MARK: - Internal
    
    /**
     NativeUIKit: Call for update to current avatar appearance.
     */
    internal func updateAvatarAppearance() {
        switch avatarAppearance {
        case .loading:
            activityIndicatorView.startAnimating()
            avatarButton.isHidden = true
            placeholderButton.isHidden = true
        case .placeholder:
            activityIndicatorView.stopAnimating()
            avatarButton.isHidden = true
            placeholderButton.isHidden = false
        case .avatar(let image):
            activityIndicatorView.stopAnimating()
            avatarButton.isHidden = false
            avatarButton.setImage(image)
            placeholderButton.isHidden = true
        }
    }
    
    /**
     NativeUIKit: Call for update to current edit appearance.
     */
    internal func updateEditAppearance() {
        if isEditable {
            switch avatarAppearance {
            case .loading:
                indicatorButton.isHidden = true
            case .placeholder:
                indicatorButton.isHidden = false
                indicatorButton.setImage(indicatorAddImage)
                indicatorButton.applyDefaultAppearance(with: indicatorAddColorise)
            case .avatar(_):
                indicatorButton.isHidden = false
                indicatorButton.setImage(indicatorEditImage)
                indicatorButton.applyDefaultAppearance(with: indicatorEditColorise)
            }
        } else {
            indicatorButton.isHidden = true
        }
        
        [placeholderButton, avatarButton, indicatorButton].forEach({ $0.isUserInteractionEnabled = isEditable })
    }
    
    // MARK: - Models
    
    /**
     NativeUIKit: Appearance states for avatar view.
     */
    public enum AvatarAppearance {
        
        case loading
        case placeholder
        case avatar(_ image: UIImage)
    }
    
    /**
     NativeUIKit: Appearance states for edit button.
     */
    public enum EditAppearance {
        
        case none
        case edit
        case add
    }
}*/
#endif
