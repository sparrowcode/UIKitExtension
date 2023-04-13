#if canImport(UIKit) && (os(iOS))
import UIKit
import SwiftBoost

open class UIBorderedView: UICommonView {
    
    // MARK: - Data
    
    open var position: Position = .top {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: - Views
    
    private let borderView = UICommonView().do {
        if #available(iOS 13.0, *) {
            $0.backgroundColor = .separator
        } else {
            $0.backgroundColor = .systemGray
        }
    }
    
    // MARK: - Init
    
    public init(position: Position) {
        self.position = position
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(borderView)
    }
    
    // MARK: - Actions
    
    public func setBorderVisible(_ visible: Bool, animated: Bool) {
        let work = { [weak self] in
            guard let self = self else { return }
            self.borderView.alpha = visible ? 1 : 0
        }
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                work()
            })
        } else {
            work()
        }
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let leftMargin = self.layoutMargins.left
        let rightMargin = self.layoutMargins.right
        borderView.frame.setWidth(frame.width - leftMargin - rightMargin)
        borderView.frame.setHeight(0.7)
        borderView.frame.origin.x = leftMargin
        switch position {
        case .top:
            borderView.frame.origin.y = 0
        case .bottom:
            borderView.frame.setMaxY(frame.height)
        }
    }
    
    // MARK: - Models
    
    public enum Position {
        
        case top
        case bottom
    }
}
#endif
