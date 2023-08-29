#if canImport(UIKit) && (os(iOS))
import UIKit

open class UIGradientView: UICommonView {
    
    open var gradientLayer = CAGradientLayer()
    
    open var startColor = UIColor.white {
        didSet {
            updateGradient()
        }
    }
    
    open var endColor = UIColor.black {
        didSet {
            updateGradient()
        }
    }
    
    open var startColorPosition = Position.topLeft  {
        didSet {
            updateGradient()
        }
    }
    
    open var endColorPosition = Position.bottomRight  {
        didSet {
            updateGradient()
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Lifecycle
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateGradient()
    }
    
    // MARK: - Layout
    
    open override func layoutSublayers(of layer: CALayer) {
        gradientLayer.frame = self.bounds
        super.layoutSublayers(of: layer)
    }
    
    // MARK: - Helpers
    
    private func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startColorPosition.point
        gradientLayer.endPoint = endColorPosition.point
    }
    
    // MARK: - Models
    
    public enum Position {
        
        case topLeft
        case topCenter
        case topRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        case mediumLeft
        case mediumRight
        case mediumCenter
        
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint.init(x: 0, y: 0)
            case .topCenter:
                return CGPoint.init(x: 0.5, y: 0)
            case .topRight:
                return CGPoint.init(x: 1, y: 0)
            case .bottomLeft:
                return CGPoint.init(x: 0, y: 1)
            case .bottomCenter:
                return CGPoint.init(x: 0.5, y: 1)
            case .bottomRight:
                return CGPoint.init(x: 1, y: 1)
            case .mediumLeft:
                return CGPoint.init(x: 0, y: 0.5)
            case .mediumRight:
                return CGPoint.init(x: 1, y: 0.5)
            case .mediumCenter:
                return CGPoint.init(x: 0.5, y: 0.5)
            }
        }
    }
}
#endif
