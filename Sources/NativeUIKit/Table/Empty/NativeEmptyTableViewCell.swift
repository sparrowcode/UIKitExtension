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

open class NativeEmptyTableViewCell: SPTableViewCell {
    
    // MARK: - Data
    
    open var verticalMargins: Margins = .medium {
        didSet {
            contentView.layoutMargins.top = self.verticalMargins.value
            contentView.layoutMargins.bottom = self.verticalMargins.value
        }
    }
    
    // MARK: - Views
    
    public let placeholderView = NativePlaceholderView().do {
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        selectionStyle = .none
        contentView.addSubview(placeholderView)
        updateBackgroundColorByParent()
    }
    
    // MARK: - Lifecycle
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateBackgroundColorByParent()
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderView.frame.origin.y = contentView.layoutMargins.top
        placeholderView.setWidthAndFit(width: contentView.layoutWidth)
        placeholderView.setXCenter()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        let calculatedHeight = placeholderView.frame.maxY + contentView.layoutMargins.bottom
        let bottomInset = calculatedHeight * (1 - 0.94)
        return .init(width: superSize.width, height: calculatedHeight + bottomInset)
    }
    
    // MARK: - Actions
    
    private func updateBackgroundColorByParent() {
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor.systemDownedGroupedBackground
        }
        /*if let superView = self.superview?.superview {
            let superViewBackgroundColor = superView.backgroundColor ?? .clear
            if superViewBackgroundColor == .systemGroupedBackground {
                backgroundColor =  UIColor.init(
                    light: superViewBackgroundColor.mixWithColor(.darkGray, amount: 0.09).mixWithColor(.systemBlue, amount: 0.01),
                    dark: .secondarySystemGroupedBackground.alpha(0.7)
                )
            } else {
                // Here not implemented becouse not using never for now.
                backgroundColor = .red
            }
        }*/
    }
    
    // MARK: - Models
    
    public enum Margins {
        
        case small
        case medium
        case large
        
        var value: CGFloat {
            switch self {
            case .small: return 16
            case .medium: return 32
            case .large: return 48
            }
        }
    }
}
#endif
