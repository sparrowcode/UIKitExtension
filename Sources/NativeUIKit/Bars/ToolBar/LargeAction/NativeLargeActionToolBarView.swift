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

open class NativeLargeActionToolBarView: NativeMimicrateToolBarView {
    
    // MARK: - Views
    
    public let activityIndicatorView = UIActivityIndicatorView()
    
    public let actionButton = NativeLargeActionButton().do {
        $0.applyDefaultAppearance(with: .tintedColorful)
    }
    
    public let footerLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = .zero
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .black.alpha(0.5)
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        addSubview(activityIndicatorView)
        addSubview(actionButton)
        addSubview(footerLabel)
    }
    
    // MARK: - Actions
    
    open func setLoading(_ state: Bool) {
        if state {
            activityIndicatorView.startAnimating()
            actionButton.isHidden = true
            footerLabel.isHidden = true
        } else {
            activityIndicatorView.stopAnimating()
            actionButton.isHidden = false
            footerLabel.isHidden = false
        }
    }
    
    // MARK: - Layout
    
    internal let footerLeftInset: CGFloat = 20
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.layout(y: layoutMargins.top)
        if footerLabel.text != nil {
            footerLabel.layoutDynamicHeight(x: layoutMargins.left + footerLeftInset, y: actionButton.frame.maxY + 12, width: layoutWidth - footerLeftInset)
        }
        
        let contentHeight: CGFloat = {
            if footerLabel.text == nil {
                return actionButton.frame.maxY
            } else {
                return footerLabel.frame.maxY
            }
        }()
        activityIndicatorView.setXCenter()
        activityIndicatorView.center.y = contentHeight / 2
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        if footerLabel.text == nil {
            return .init(width: size.width, height: actionButton.frame.maxY + layoutMargins.bottom)
        } else {
            return .init(width: size.width, height: footerLabel.frame.maxY + layoutMargins.bottom)
        }
    }
}
#endif
