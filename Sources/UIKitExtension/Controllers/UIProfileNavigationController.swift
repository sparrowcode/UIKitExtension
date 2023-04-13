import UIKit
import SwiftBoost

open class UIProfileNavigationController: UICommonNavigationController {
    
    open lazy var avatarControl = UIAvatarControl()
    
    open lazy var navigationSubtitleLabel = UILabel().do {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
        $0.text = nil
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
    }
    
    // MARK: - UINavigationControllerDelegate
    
    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if !isShowProfile(for: viewController) {
            removeAvatarControl()
        }
    }
    
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if isShowProfile(for: viewController) {
            addAvatarControl()
        }
    }
    
    // MARK: - Profile
    
    private var profileAnimationDuration: TimeInterval { 0.12 }
    
    open func isShowProfile(for viewController: UIViewController) -> Bool {
        return (viewController as? UIProfileNavigationControllerDelegate)?.isShowProfile ?? false
    }
    
    internal func addAvatarControl() {
        
        let navBar = navigationBar
        navBar.subviews.forEach { subview in
            
            let stringFromClass = NSStringFromClass(subview.classForCoder)
#if targetEnvironment(macCatalyst)
            guard stringFromClass.contains("UINavigationBarContentView") else { return }
#else
            guard stringFromClass.contains("UINavigationBarLargeTitleView") else { return }
#endif
            
            if avatarControl.superview != subview {
                avatarControl.removeFromSuperview()
                subview.addSubview(avatarControl)
            }
            
            avatarControl.alpha = .zero
            avatarControl.isUserInteractionEnabled = true
            UIView.animate(withDuration: profileAnimationDuration, delay: .zero, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.avatarControl.alpha = 1
            })
            
            avatarControl.translatesAutoresizingMaskIntoConstraints = false
            avatarControl.removeConstraints(avatarControl.constraints)
            avatarControl.widthAnchor.constraint(equalToConstant: 36).isActive = true
            avatarControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
            avatarControl.bottomAnchor.constraint(equalTo: avatarControl.superview!.bottomAnchor, constant: -10).isActive = true
            avatarControl.trailingAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        }
    }
    
    internal func removeAvatarControl() {
        self.navigationSubtitleLabel.removeFromSuperview()
        UIView.animate(withDuration: profileAnimationDuration, delay: .zero, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseInOut], animations: {
            self.avatarControl.alpha = .zero
        }, completion: { finished in
            if finished {
                self.avatarControl.removeFromSuperview()
            }
        })
    }
}

public protocol UIProfileNavigationControllerDelegate {
    
    var isShowProfile: Bool { get }
}
