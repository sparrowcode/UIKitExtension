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

open class NativeNavigationScrollWorker: NSObject {
    
    private weak var scrollView: UIScrollView?
    private let scrollBehavior: NativeNavigationScrollBehavior
    private let heightForChangeNavigationAppearance: CGFloat = 16
    
    init(scrollView: UIScrollView, scrollBehavior: NativeNavigationScrollBehavior) {
        self.scrollView = scrollView
        self.scrollBehavior = scrollBehavior
        super.init()
        scrollView.contentInset.top = heightForChangeNavigationAppearance
        scrollView.contentInset.bottom = NativeLayout.Spaces.Scroll.bottom_inset_reach_end
    }
    
    public func scrollViewDidScroll() {
        switch scrollBehavior {
        case .default:
            break
        case .hidable:
            guard let scrollView = self.scrollView else { return }
            let contentOffsetY = scrollView.safeAreaInsets.top + scrollView.contentInset.top + scrollView.contentOffset.y
            let spaceToNavigationBottom = scrollView.contentInset.top
            let progress = (heightForChangeNavigationAppearance - (spaceToNavigationBottom - contentOffsetY)) / heightForChangeNavigationAppearance
            scrollView.viewController?.navigationController?.navigationBar.setBackgroundAlpha(progress)
        }
    }
}
#endif
