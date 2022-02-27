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

/**
 NativeUIKit: View with mimicrate to navigation and toolbar views.
 */
open class NativeMimicrateBarView: SPView {
    
    // MARK: - Views
    
    public let borderedView: NativeBorderedView
    public let backgroundView: UIVisualEffectView
    
    // MARK: - Init
    
    public init(borderPosition: NativeBorderedView.Position) {
        self.borderedView = NativeBorderedView(position: borderPosition)
        self.backgroundView = UIVisualEffectView.init(style: .regular)
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        addSubview(backgroundView)
        addSubview(borderedView)
        setVisible(progress: 1)
    }
    
    // MARK: - Actions
    
    /**
     NativeUIKit: Show or hide bar.
     
     - parameter progress: Value in range from `0` to `1` to visible or not view.
     */
    open func setVisible(progress: CGFloat) {
        var alpha: CGFloat = progress
        if progress < 0 { alpha = 0 }
        if progress > 1 { alpha = 1 }
        self.borderedView.alpha = alpha
        self.backgroundView.alpha = alpha
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.setEqualSuperviewBounds()
        borderedView.setEqualSuperviewBounds()
    }
}
#endif
