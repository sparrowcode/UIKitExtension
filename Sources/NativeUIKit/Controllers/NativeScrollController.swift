// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.by)
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

/**
 NativeUIKit: Hide navigation bar when scrolling to up.
 */
open class NativeScrollController: SPScrollController {
    
    // MARK: - Data
    
    /**
     NativeUIKit: Scroll Behavior for navigation bar.
     */
    public let navigationScrollBehavior: NavigationScrollBehavior
    
    /**
     NativeUIKit: Set height for change navigation appearance in this range.
     */
    open var heightForChangeNavigationAppearance: CGFloat = .zero {
        didSet {
            scrollView.contentInset.top = heightForChangeNavigationAppearance
            scrollView.contentInset.bottom = NativeLayout.Spaces.Scroll.bottom_inset_reach_end
            scrollView.delegate?.scrollViewDidScroll?(self.scrollView)
        }
    }
    
    // MARK: - Views
    
    open var toolBarView: NativeMimicrateToolBarView? = nil {
        willSet {
            if let toolBarView = toolBarView {
                toolBarView.removeFromSuperview()
            }
        }
        didSet {
            if let toolBarView = toolBarView {
                view.addSubview(toolBarView)
            }
        }
    }

    // MARK: - Init
    
    public override init() {
        self.navigationScrollBehavior = .default
        super.init()
    }
    
    public init(navigationScrollBehavior: NavigationScrollBehavior) {
        self.navigationScrollBehavior = navigationScrollBehavior
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        scrollView.delegate = self
        switch self.navigationScrollBehavior {
        case .default:
            break
        case .hidable:
            heightForChangeNavigationAppearance = 16
        }
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let toolBarView = toolBarView {
            toolBarView.layoutMargins.bottom = systemSafeAreaInsets.bottom + 16
            toolBarView.setWidthAndFit(width: view.frame.width)
            toolBarView.frame.setMaxY(view.frame.height)
            let toolBarFrameFitHeight = toolBarView.frame.height - systemSafeAreaInsets.bottom
            if additionalSafeAreaInsets.bottom != toolBarFrameFitHeight {
                additionalSafeAreaInsets.bottom = toolBarFrameFitHeight
            }
        }
        
    }
    
    // MARK: - Models
    
    public enum NavigationScrollBehavior {
        
        case `default`
        case hidable
    }
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch navigationScrollBehavior {
        case .default:
            break
        case .hidable:
            let contentOffsetY = scrollView.safeAreaInsets.top + scrollView.contentInset.top + scrollView.contentOffset.y
            let spaceToNavigationBottom = scrollView.contentInset.top
            let progress = (heightForChangeNavigationAppearance - (spaceToNavigationBottom - contentOffsetY)) / heightForChangeNavigationAppearance
            navigationController?.navigationBar.setBackgroundAlpha(progress)
        }
    }
}
#endif
