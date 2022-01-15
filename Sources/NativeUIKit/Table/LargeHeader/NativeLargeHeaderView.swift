// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
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

open class NativeLargeHeaderView: SPView {

    // MARK: - Views
    
    public let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
    }
    
    public let button = SPDimmedButton().do {
        $0.applyDefaultAppearance(with: .tintedContent)
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .init(top: 32, left: .zero, bottom: 14, right: .zero)
        insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        addSubviews(titleLabel, button)
    }
    
    // MARK: - Layout
    
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        setWidthAndFit(width: superview.layoutWidth)
        setXCenter()
        frame.origin.y = y
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.layoutDynamicHeight(
            x: layoutMargins.left,
            y: layoutMargins.top,
            width: layoutWidth
        )
        button.sizeToFit()
        button.setMaxXToSuperviewRightMargin()
        button.center.y = titleLabel.center.y
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: titleLabel.frame.maxY + layoutMargins.bottom)
    }
}
#endif
