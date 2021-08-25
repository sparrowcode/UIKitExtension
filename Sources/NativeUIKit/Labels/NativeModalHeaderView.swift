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
 NativeUIKit: Usually use in modal screen with large title and subtitle.
 Image is optional.
 */
open class NativeModalHeaderView: SPView {
    
    // MARK: - Views
    
    public let iconImageView = SPImageView().do {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .tint
    }
    
    public let titleLabel = SPLabel().do {
        $0.numberOfLines = .zero
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle, weight: .bold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
        $0.textAlignment = .center
    }
    
    public let subtitleLabel = SPLabel().do {
        $0.numberOfLines = .zero
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .black.alpha(0.5)
        }
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    
    public override init() {
        super.init()
    }
    
    public init(image: UIImage?, title: String, subtitle: String) {
        super.init()
        titleLabel.text = title
        subtitleLabel.text = subtitle
        iconImageView.image = image
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        backgroundColor = .clear
        layoutMargins = .zero
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(iconImageView)
    }
    
    // MARK: - Layout
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(y: CGFloat) {
        guard let superview = self.superview else { return }
        let width = min(superview.readableWidth, NativeLayout.Sizes.not_actionable_area_maximum_width)
        setWidthAndFit(width: width)
        setXCenter()
        frame.origin.y = y
    }
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout button.
     */
    open func layout(maxY: CGFloat) {
        guard let superview = self.superview else { return }
        let width = min(superview.readableWidth, NativeLayout.Sizes.not_actionable_area_maximum_width)
        setWidthAndFit(width: width)
        setXCenter()
        frame.setMaxY(maxY)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.sizeToFit()
        iconImageView.setXCenter()
        iconImageView.frame.origin.y = layoutMargins.top
        
        if let _ = iconImageView.image {
            titleLabel.layoutDynamicHeight(x: .zero, y: iconImageView.frame.maxY + 12, width: layoutWidth)
        } else {
            titleLabel.layoutDynamicHeight(x: .zero, y: .zero, width: layoutWidth)
        }
        
        subtitleLabel.layoutDynamicHeight(x: .zero, y: titleLabel.frame.maxY + 4, width: titleLabel.frame.width)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: subtitleLabel.frame.maxY + layoutMargins.bottom)
    }
}
#endif
