import UIKit

open class UICommonSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    @available(iOS 14.0, *)
    public override init(style: UISplitViewController.Style) {
        super.init(style: style)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {}
}
