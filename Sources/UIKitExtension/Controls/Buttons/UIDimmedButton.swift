#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

/**
 UIKitExtension: Button with process dimmed colors.
 
 Button support color states like `basic`, `dimmed` and `disabled`.
 For change it using `Colorise` object.
 
 Also available tinting for all modes.
 */
open class UIDimmedButton: UICommonButton {
    
    open override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateAppearance()
    }
    
    /**
     UIKitExtension: Higlight style when button pressing.
     
     If set content, only label and image change opacity.
     If choosed background, area of button will change opacity.
     */
    open var higlightStyle = HiglightStyle.default
    
    // MARK: - Colorises
    
    private lazy var defaultColorise = Colorise(content: tintColor, background: .clear)
    private lazy var disabledColorise = Colorise(content: .dimmedContent, background: .clear)
    private lazy var dimmedColorise = Colorise(content: .dimmedContent, background: .clear)
    
    // MARK: - Data
    
    /**
     UIKitExtension: Opacity of elements when button higlight.
     */
    open var highlightOpacity: CGFloat = 0.7
    
    // MARK: - Process
    
    open func setColorise(_ colorise: Colorise, for state: AppearanceState) {
        switch state {
        case .default:
            defaultColorise = colorise
        case .dimmed:
            dimmedColorise = colorise
        case .disabled:
            disabledColorise = colorise
        }
        updateAppearance()
    }
    
    open func getColorise(for state: AppearanceState) -> Colorise {
        switch state {
        case .default:
            return defaultColorise
        case .dimmed:
            return dimmedColorise
        case .disabled:
            return disabledColorise
        }
    }
    
    /**
     UIKitExtension: Set the color scheme for the default state.
     `.dimmed` and `.disabled` states calculate automaticaly.
     */
    open func applyDefaultAppearance(with colorise: Colorise? = nil) {
        defaultColorise = colorise ?? Colorise(content: .tint, background: .custom(.clear))
        let defaultBackgroundColor = colorFromColoriseMode(defaultColorise.background)
        let dimmedBackground = (defaultBackgroundColor == .clear) ? UIColor.clear : .dimmedBackground
        dimmedColorise = Colorise(content: .dimmedContent, background: dimmedBackground)
        disabledColorise = Colorise(content: .dimmedContent, background: dimmedBackground)
        updateAppearance()
    }
    
    private func updateAppearance() {
        if tintAdjustmentMode == .dimmed {
            applyColorise(dimmedColorise)
        } else if isEnabled {
            let colorise = self.defaultColorise
            applyColorise(colorise)
            
            // Image Tint Color
            var imageTintColor = colorFromColoriseMode(colorise.icon)
            imageTintColor = imageTintColor.withAlphaComponent(isHighlighted ? imageTintColor.alpha * highlightOpacity : imageTintColor.alpha)
            imageView?.tintColor = imageTintColor
            
            // Higlight
            switch higlightStyle {
            case .content:
                break
            case .background:
                let color = colorFromColoriseMode(colorise.background)
                backgroundColor = color.alpha(isHighlighted ? color.alpha * highlightOpacity : color.alpha)
            }
        } else {
            applyColorise(disabledColorise)
        }
    }
    
    private func applyColorise(_ colorise: Colorise) {
        let titleColor = colorFromColoriseMode(colorise.title)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(highlightOpacity), for: .highlighted)
        imageView?.tintColor = colorFromColoriseMode(colorise.icon)
        backgroundColor = colorFromColoriseMode(colorise.background)
    }
    
    /**
     UIKitExtension: Get valid color by `Colorise.Mode` for this button.
     
     For example each call can return diffrent color for if changing tint.
     If mode in custom always return this value.
     
     - parameter mode: Colorise mode from which need get color.
     */
    public func colorFromColoriseMode(_ mode: Colorise.Mode) -> UIColor {
        switch mode {
        case .tint: return self.tintColor
        case .secondaryTint: return self.tintColor.secondary
        case .custom(let color): return color
        }
    }
    
    // MARK: - Models
    
    /**
     UIKitExtension: Represent colors for state of button for elements.
     */
    public struct Colorise {
        
        public var title: Mode
        public var icon: Mode
        public var background: Mode
        
        public init(content: Mode, background: Mode) {
            self.title = content
            self.icon = content
            self.background = background
        }
        
        public init(content: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(content)
            self.background = .custom(background)
        }
        
        public init(content: UIColor, icon: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(icon)
            self.background = .custom(background)
        }
        
        /**
         UIKitExtension: Represent of rendering colors in button.
         
         It need for have dynamic tint color and fixed custom.
         */
        public enum Mode {
            
            /**
             UIKitExtension: Always specific color.
             */
            case custom(UIColor)
            
            /**
             UIKitExtension: Observe and apply tint color of button.
             */
            case tint
            
            /**
             UIKitExtension: Observe and apply secondary tint color of button.
             */
            case secondaryTint
        }
        
        // MARK: - Ready Use
        
        public static var tintedContent: Colorise {
            return .init(content: .tint, background: .custom(.clear))
        }
        
        #if os(iOS)
        @available(iOS 13.0, *)
        public static var tintedContentSecondaryBackground : Colorise {
            return .init(content: .tint, background: .custom(.secondarySystemBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentTertiaryBackground : Colorise {
            return .init(content: .tint, background: .custom(.tertiarySystemBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentSecondaryGroupBackground : Colorise {
            return .init(content: .tint, background: .custom(.secondarySystemGroupedBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentTertiaryGroupBackground : Colorise {
            return .init(content: .tint, background: .custom(.tertiarySystemGroupedBackground))
        }
        #endif
        
        public static var tintedColorful: Colorise {
            return .init(content: .custom(.white), background: .tint)
        }
        
        public static var tinted: Colorise {
            return .init(content: .tint, background: .secondaryTint)
        }
    }
    
    public enum HiglightStyle {
        
        case content
        case background
        
        static var `default`: HiglightStyle {
            return .background
        }
    }
    
    public enum AppearanceState {
        
        /**
         UIKitExtension: The button is in the normal state.
         */
        case `default`
        
        /**
         UIKitExtension: The button is in a dimmed state, for example when another `UIViewController` is presented.
         */
        case dimmed
        
        /**
         UIKitExtension: The button is disabled. Controlled through the `isDisabled` property.
         */
        case disabled
    }
}
#endif
