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

open class NativeMimicrateToolBarView: NativeMimicrateBarView {
    
    // MARK: - Init
    
    public init() {
        super.init(borderPosition: .top)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        layoutMargins.top = 16
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = superview else { return }
        let contentWidth = min(440, superview.readableWidth)
        let horizontalMargin = (frame.width - contentWidth) / 2
        layoutMargins.left = horizontalMargin
        layoutMargins.right = horizontalMargin
    }
}
#endif
