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

#if canImport(UIKit) && canImport(AuthenticationServices) && (os(iOS))
import UIKit
import SparrowKit
import AuthenticationServices

@available(iOS 13.0, *)
open class NativeAppleAuthToolBarView: NativeMimicrateToolBarView {
    
    // MARK: - Views
    
    public let authButton = ASAuthorizationAppleIDButton()
    
    public let footerLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = .zero
        $0.textColor = .secondaryLabel
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        addSubview(authButton)
        addSubview(footerLabel)
    }
    
    // MARK: - Layout
    
    internal let footerLeftInset: CGFloat = 20
    
    open override func layoutSubviews() {
        super.layoutSubviews()

        let authButtonWidth = min(readableWidth, NativeLayout.Sizes.actionable_area_maximum_width)
        authButton.frame.setWidth(authButtonWidth)
        authButton.frame.setHeight(52)
        authButton.setXCenter()
        authButton.frame.origin.y = layoutMargins.top
        
        if footerLabel.text != nil {
            footerLabel.layoutDynamicHeight(x: layoutMargins.left + footerLeftInset, y: authButton.frame.maxY + 12, width: layoutWidth - footerLeftInset)
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        if footerLabel.text == nil {
            return .init(width: size.width, height: authButton.frame.maxY + layoutMargins.bottom)
        } else {
            return .init(width: size.width, height: footerLabel.frame.maxY + layoutMargins.bottom)
        }
    }
}
#endif
