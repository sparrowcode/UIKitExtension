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

open class NativeLargeTextField: SPInsetsTextField {
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = .white
        }
        layer.cornerRadius = NativeAppearance.Corners.readable_area
        textAlignment = .center
        clearButtonMode = .whileEditing
        contentMode = .scaleAspectFit
        font = .preferredFont(forTextStyle: .title2, weight: .bold, addPoints: .zero)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 16
        insets = .init(horizontal: 48, vertical: 14)
    }
    
    // MARK: - Lifecycle
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        textColor = tintColor
    }
    
    // MARK: - Layout
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        sizeToFit()
        let width = min(superview.readableWidth, NativeLayout.Sizes.actionable_area_maximum_width)
        frame.setWidth(width)
        setXCenter()
        frame.origin.y = y
    }
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(maxY: CGFloat) {
        guard let superview = self.superview else { return }
        sizeToFit()
        let width = min(superview.readableWidth, NativeLayout.Sizes.actionable_area_maximum_width)
        frame.setWidth(width)
        setXCenter()
        frame.setMaxY(maxY)
    }
}
#endif
