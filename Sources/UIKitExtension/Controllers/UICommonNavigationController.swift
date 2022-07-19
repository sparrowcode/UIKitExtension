import UIKit

open class UICommonNavigationController: UINavigationController, UICommonInit {
    
    // MARK: - Init
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    open func commonInit() {}
    
    // MARK: - Layout
    
    /**
     UIKitExtension: If set to `true`, navigation bar apply horizontal margins from view of navigation controller.
     Default is `false`.
     */
    open var inheritLayoutMarginsForNavigationBar: Bool = false
    
    /**
     UIKitExtension: If set to `true`, child controllers apply horizontal margins from view of navigation controller.
     Default is `false`.
     */
    open var inheritLayoutMarginsForСhilds: Bool = false
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Inhert of Navigation Bar
        
        if inheritLayoutMarginsForNavigationBar {
            
            let leftMargin = view.layoutMargins.left
            let rightMargin = view.layoutMargins.left
            
            if navigationBar.layoutMargins.left != leftMargin {
                navigationBar.layoutMargins.left = leftMargin
            }
            if navigationBar.layoutMargins.right != rightMargin {
                navigationBar.layoutMargins.right = rightMargin
            }
        }
        
        // Inhert Childs Controllers
        
        if inheritLayoutMarginsForСhilds {
            
            let leftMargin = view.layoutMargins.left
            let rightMargin = view.layoutMargins.left
            
            for childController in viewControllers {
                if childController.view.layoutMargins.left != leftMargin {
                    childController.view.layoutMargins.left = leftMargin
                }
                if childController.view.layoutMargins.right != rightMargin {
                    childController.view.layoutMargins.right = rightMargin
                }
            }
        }
    }
}
