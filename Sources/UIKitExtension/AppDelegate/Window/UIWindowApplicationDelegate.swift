#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

/**
 UIKitExtension:  App which not using with scenes, only with one window key.
 */
open class UIWindowApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    /**
     UIKitExtension:  Ready-use window property.
     
     For correct configure, call `makeKeyAndVisible`.
     */
    open var window: UIWindow?
    
    /**
     UIKitExtension: Configure window and make it present.
     
     Method init window and configure with your tint and controller.
     
     - warning:
     Use it only if none-scene mode.
     
     - parameter createViewControllerHandler: Handler for get root controller for window.
     - parameter tint: Tint color for window.
     */
    open func makeKeyAndVisible(createViewControllerHandler: () -> UIViewController, tint: UIColor) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.tintColor = tint
        window?.rootViewController = createViewControllerHandler()
        window?.makeKeyAndVisible()
    }
    
    /**
     UIKitExtension: Configure window and make it present.
     
     Method init window and configure with your tint and controller.
     
     - warning:
     Use it only if none-scene mode.
     
     - parameter viewController: Root controller for window.
     - parameter tint: Tint color for window.
     */
    open func makeKeyAndVisible(viewController: UIViewController, tint: UIColor) {
        makeKeyAndVisible(createViewControllerHandler: {
            return viewController
        }, tint: tint)
    }
}
#endif
