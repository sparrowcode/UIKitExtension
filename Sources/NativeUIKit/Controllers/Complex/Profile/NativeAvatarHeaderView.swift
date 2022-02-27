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

@available(iOS 13.0, *)
open class NativeAvatarHeaderView: SPView {
    
    // MARK: - Public
    
    public let avatarView = NativeAvatarView().do {
        $0.avatarAppearance = .placeholder
        $0.isEditable = true
    }
    
    // MARK: - Private
    
    private var extendView = SPView()
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        backgroundColor = .clear
        addSubviews([extendView, avatarView])
        
        layoutMargins = .init(
            top: NativeLayout.Spaces.default,
            left: NativeLayout.Spaces.default_double,
            bottom: NativeLayout.Spaces.default,
            right: NativeLayout.Spaces.default_double
        )
    }
    
    // MARK: - Ovveride
    
    open override var backgroundColor: UIColor? {
        didSet {
            extendView.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        extendView.frame = .init(x: .zero, maxY: .zero, width: frame.width, height: 1000)
        
        avatarView.sizeToFit()
        avatarView.setXCenter()
        avatarView.frame.origin.y = layoutMargins.top
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: frame.width, height: avatarView.frame.maxY + layoutMargins.bottom)
    }
}
#endif
