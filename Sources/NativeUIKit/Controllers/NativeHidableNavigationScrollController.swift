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
open class NativeHidableNavigationScrollController: SPScrollController {
    
    /**
     NativeUIKit: Set height for change navigation appearance in this range.
     If set large value, for navigation hide take more scroll distance.
     Default value is `16`.
     */
    open var heightForChangeAppearanceNavigation: CGFloat = defaultHeightForChangeAppearanceNavigation {
        didSet {
            scrollView.contentInset.top = heightForChangeAppearanceNavigation
            scrollView.contentInset.bottom = NativeLayout.Spaces.Scroll.bottom_inset_reach_end
            scrollView.delegate?.scrollViewDidScroll?(self.scrollView)
        }
    }
    
    private static var defaultHeightForChangeAppearanceNavigation: CGFloat = 16
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        heightForChangeAppearanceNavigation = Self.defaultHeightForChangeAppearanceNavigation
    }
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y + scrollView.safeAreaInsets.top + scrollView.contentInset.top
        let spaceToNavigationBottom = scrollView.contentInset.top
        let progress = (heightForChangeAppearanceNavigation - (spaceToNavigationBottom - contentOffsetY)) / heightForChangeAppearanceNavigation
        navigationController?.navigationBar.setBackgroundAlpha(progress)
    }
}
#endif
