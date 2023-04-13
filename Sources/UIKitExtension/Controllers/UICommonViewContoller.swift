import UIKit

open class UICommonViewContoller: UIViewController, UICommonInit {
    
    // MARK: - Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {}
    
    // MARK: - Toolbar
    
    //open var extendedToolbarContainerView: UIToolbarContainerView.ContainerView? = nil
    
}
