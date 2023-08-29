import UIKit

open class UIPopoverNavigationController: UICommonNavigationController, UIPopoverPresentationControllerDelegate {
    
    public init(rootController: UIViewController, preferredContentSize size: CGSize, sourceView: UIView, direction: UIPopoverArrowDirection) {
        super.init(rootViewController: rootController)
        
        modalPresentationStyle = .popover
        preferredContentSize = size
        popoverPresentationController?.permittedArrowDirections = [direction]
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = sourceView.frame
        popoverPresentationController?.delegate = self
    }
    
    public init(rootController: UIViewController, preferredContentSize size: CGSize, sourceBarButtonItem: UIBarButtonItem, direction: UIPopoverArrowDirection) {
        super.init(rootViewController: rootController)
        
        modalPresentationStyle = .popover
        preferredContentSize = size
        popoverPresentationController?.permittedArrowDirections = [direction]
        popoverPresentationController?.barButtonItem = sourceBarButtonItem
        popoverPresentationController?.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
