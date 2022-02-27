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
import SPPerspective

open class NativePromoView: SPView {
    
    // MARK: - Views
    
    public let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }
    
    public let descriptionLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular)
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .black.alpha(0.5)
        }
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }
    
    public let iconView = SPImageView().do {
        $0.backgroundColor = .clear
    }
    
    public let button = SPDimmedButton().do {
        $0.applyDefaultAppearance(with: .tintedContent)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold, addPoints: 2)
    }
    
    public let areaView = SPView().do {
        if #available(iOS 13.0, *) {
            $0.backgroundColor = UIColor.secondarySystemBackground
        }
        $0.layer.cornerRadius = 15
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(areaView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(iconView)
        addSubview(button)
        areaView.layoutMargins = .init(horizontal: 24, vertical: 24)
        iconView.applyPerspective(.iOS14WidgetAnimatable)
    }
    
    // MARK: - Layout
    
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        var width = min(superview.readableWidth, NativeLayout.Sizes.actionable_area_maximum_width)
        if (width == .zero) && (superview.layoutWidth != .zero) { width = superview.layoutWidth }
        setWidthAndFit(width: width)
        setXCenter()
        frame.origin.y = y
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        areaView.frame = .init(x: layoutMargins.left, y: layoutMargins.top, width: layoutWidth, height: areaView.frame.height)
        
        let labelsWidth = areaView.layoutWidth
        
        titleLabel.layoutDynamicHeight(width: labelsWidth)
        titleLabel.setXCenter()
        titleLabel.frame.origin.y = areaView.frame.origin.y + areaView.layoutMargins.top
        
        descriptionLabel.layoutDynamicHeight(width: labelsWidth)
        descriptionLabel.setXCenter()
        descriptionLabel.frame.origin.y = titleLabel.frame.maxY + 3
        
        let iconSideSize = min(titleLabel.frame.width * 0.5, 120)
        iconView.frame.setWidth(iconSideSize)
        iconView.frame.setHeight(iconSideSize)
        iconView.setXCenter()
        iconView.frame.origin.y = descriptionLabel.frame.maxY + 16
        
        areaView.frame.setHeight(iconView.frame.origin.y + iconView.frame.height / 2)
        
        button.sizeToFit()
        button.setXCenter()
        button.frame.origin.y = iconView.frame.maxY + 24
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: button.frame.maxY + layoutMargins.bottom)
    }
}

open class NativePromoContainerView: SPView {
    
    // MARK: - Views
    
    public let promoView = NativePromoView()
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(promoView)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        promoView.layout(y: layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: promoView.frame.maxY + layoutMargins.bottom)
    }
}
#endif
