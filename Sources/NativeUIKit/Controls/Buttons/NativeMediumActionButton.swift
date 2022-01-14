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
 NativeUIKit: Medium action button.
 You see it in Apply Music play and shuffle buttons.
 */
open class NativeMediumActionButton: SPDimmedButton {
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold, addPoints: .zero)
        titleLabel?.numberOfLines = 1
        titleImageInset = 8
        contentEdgeInsets = .init(horizontal: 15, vertical: 15)
        roundCorners(radius: 12)
    }
    
    // MARK: - Public
    
    /**
     NativeUIKit: Wrapper of set content and color of button.
     
     - parameter title: Text which using like title.
     - parameter icon: Object of `UIImage`, using like icon. Usually Apple doesn't use icon in this button.
     - parameter colorise: Color of button in default state.
     */
    public func set(title: String, icon: UIImage? = nil, colorise: SPDimmedButton.Colorise) {
        setTitle(title)
        if let icon = icon {
            setImage(icon.alwaysTemplate)
        }
        applyDefaultAppearance(with: colorise)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        let width = superSize.width

        var height = superSize.height
        if let titleLabel = titleLabel, let imageView = imageView, let _ = imageView.image {
            if titleLabel.frame.height > .zero && imageView.frame.height > .zero {
                let imageCorrection = imageView.frame.height - titleLabel.frame.height
                height -= imageCorrection
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Wrappers
    
    public static var defaultCornerRadius: CGFloat {
        let button = NativeMediumActionButton()
        return button.layer.cornerRadius
    }
    
    public static var defaultHeight: CGFloat {
        let button = NativeMediumActionButton()
        button.setTitle(.space)
        button.sizeToFit()
        return button.frame.height
    }
}
#endif
