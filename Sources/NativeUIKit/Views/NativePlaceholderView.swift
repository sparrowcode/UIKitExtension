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

open class NativePlaceholderView: SPButton {
    
    // MARK: - Views
    
    public let iconImageView = SPImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    public let headerLabel = SPLabel().do {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
    }
    
    public let descriptionLabel = SPLabel().do {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular)
    }
    
    // MARK: - Init
    
    public override init() {
        super.init()
    }
    
    public init(icon: UIImage, title: String, subtitle: String) {
        super.init()
        iconImageView.image = icon.alwaysTemplate
        headerLabel.text = title
        descriptionLabel.text = subtitle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        if #available(iOS 13.0, *) {
            tintColor = .tertiaryLabel
        } else {
            tintColor = UIColor.black.alpha(0.3)
        }
        backgroundColor = .clear
        iconImageView.tintColor = tintColor
        addSubview(iconImageView)
        headerLabel.textColor = tintColor
        addSubview(headerLabel)
        descriptionLabel.textColor = tintColor
        addSubview(descriptionLabel)
    }
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? NativeAppearance.actionable_element_highlight_opacity : 1
            }, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    open func setVisible(_ state: Bool, animated: Bool) {
        let work = { [weak self] in
            guard let self = self else { return }
            self.alpha = state ? 1 : .zero
        }
        if animated {
            UIView.animate(withDuration: 0.45, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                work()
            }, completion: nil)
        } else {
            work()
        }
    }
    
    // MARK: - Layout
    
    /**
     NativeUIKit: Layout wrapper. Native way for layout placeholder.
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
     NativeUIKit: Layout wrapper. Native way for layout placeholder.
     */
    open func layoutCenter() {
        guard let superview = self.superview else { return }
        let width = min(superview.readableWidth, NativeLayout.Sizes.actionable_area_maximum_width)
        setWidthAndFit(width: width)
        setXCenter()
        center.y = (superview.frame.height / 2) * 0.94
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.sizeToFit()
        iconImageView.setXCenter()
        iconImageView.frame.origin.y = layoutMargins.top
        headerLabel.layoutDynamicHeight(width: layoutWidth)
        headerLabel.frame.origin.y = iconImageView.frame.maxY + 12
        headerLabel.setXCenter()
        descriptionLabel.layoutDynamicHeight(width: layoutWidth)
        descriptionLabel.frame.origin.y = headerLabel.frame.maxY + 4
        descriptionLabel.setXCenter()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: descriptionLabel.frame.maxY + layoutMargins.bottom)
    }
}
#endif
