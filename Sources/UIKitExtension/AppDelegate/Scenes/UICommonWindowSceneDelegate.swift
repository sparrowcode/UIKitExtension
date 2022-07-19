#if canImport(UIKit) && (os(iOS))
import UIKit

/**
 UIKitExtension: Basic class for scene.
 
 Has ready use window property and assets funcs for present window.
 */
@available(iOS 13.0, *)
open class UICommonWindowSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /**
     UIKitExtension: Ready-use window property.
     
     For correct configure, call `makeKeyAndVisible`.
     */
    open var window: UIWindow?
    
    /**
     UIKitExtension: Configure window and make it present.
     
     This method get controller after apply tint and window scene, in some cases it critical. For example tint of window get before valid tint set. It happen with first window and launch. For solve it use this.
     
     - parameter scene: Scene which sync to window.
     - parameter createViewControllerHandler: Handler for get root controller for window.
     - parameter tint: Tint color for window.
     */
    open func makeKeyAndVisible(in scene: UIWindowScene, createViewControllerHandler: () -> UIViewController, tint: UIColor) {
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.tintColor = tint
        window?.rootViewController = createViewControllerHandler()
        window?.makeKeyAndVisible()
    }
    
    /**
     UIKitExtension: Configure window and make it present.
     
     Set scene, tint and already created controller.
     
     - warning:
     If you get troubles with tinting, please, check other method `makeKeyAndVisible`.
     
     - parameter scene: Scene which sync to window.
     - parameter viewController: Root controller for window.
     - parameter tint: Tint color for window.
     */
    open func makeKeyAndVisible(in scene: UIWindowScene, viewController: UIViewController, tint: UIColor) {
        makeKeyAndVisible(in: scene, createViewControllerHandler: {
            return viewController
        }, tint: tint)
    }
}
#endif
