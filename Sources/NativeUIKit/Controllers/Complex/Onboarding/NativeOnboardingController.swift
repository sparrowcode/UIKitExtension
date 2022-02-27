// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS))
import UIKit
import SparrowKit
import SPPageController

open class NativeOnboardingController: SPPageController, NativeOnboardingManagerDelegate {
    
    private let controllers: [UIViewController]
    private let completion: SPCompletion
    
    // MARK: - Init
    
    public init(controllers: [UIViewController], completion: @escaping SPCompletion) {
        
        self.controllers = controllers
        self.completion = completion
        
        var childControllers: [UIViewController] = []
        for controller in controllers {
            let navigationController = NativeNavigationController(rootViewController: controller)
            navigationController.inheritLayoutMarginsForСhilds = true
            navigationController.inheritLayoutMarginsForNavigationBar = true
            navigationController.view.preservesSuperviewLayoutMargins = true
            childControllers.append(navigationController)
        }
        
        super.init(childControllers: childControllers, system: .page)
        
        controllers.forEach { controller in
            let onboardingChildController = controller as! NativeOnboardingChildInterface
            onboardingChildController.onboardingManagerDelegate = self
        }
        
        allowScroll = false
        allowDismissWithGester = false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OnboardingManagerDelegate
    
    public func onboardingActionComplete(for controller: UIViewController) {
        guard let index = controllers.firstIndex(of: controller) else { return }
        if index == (controllers.count - 1) {
            dismiss(animated: true) { [weak self] in
                self?.completion()
            }
        } else {
            safeScrollTo(index: index + 1, animated: true)
        }
    }
}

public protocol NativeOnboardingManagerDelegate: AnyObject {
    
    func onboardingActionComplete(for controller: UIViewController)
}

public protocol NativeOnboardingChildInterface: AnyObject {
    
    var onboardingManagerDelegate: NativeOnboardingManagerDelegate? { get set }
}
#endif
