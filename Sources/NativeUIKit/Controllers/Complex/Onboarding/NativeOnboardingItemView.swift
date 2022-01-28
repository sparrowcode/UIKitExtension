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

public class NativeOnboardingItemView: SPView {
    
    // MARK: - Views
    
    let iconView = SPImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .title3, weight: .semibold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
        $0.numberOfLines = .zero
    }
    
    let descriptionLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .body)
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .black
        }
        $0.numberOfLines = .zero
    }
    
    // MARK: - Init
    
    init(item: NativeOnboardingItem) {
        super.init()
        iconView.image = item.iconImage
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func commonInit() {
        super.commonInit()
        backgroundColor = .clear
        roundCorners(radius: NativeLayout.Spaces.default_less)
        layoutMargins = .init(horizontal: NativeLayout.Spaces.default_more, vertical: NativeLayout.Spaces.default_more)
        addSubviews(iconView, titleLabel, descriptionLabel)
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = .init(side: 42)
        iconView.frame.origin.y = layoutMargins.top
        iconView.frame.origin.x = layoutMargins.left
        
        let labelWidth = layoutWidth - iconView.frame.width - NativeLayout.Spaces.default
        
        titleLabel.layoutDynamicHeight(width: labelWidth)
        titleLabel.setMaxXToSuperviewRightMargin()
        titleLabel.frame.origin.y = layoutMargins.top
        
        descriptionLabel.layoutDynamicHeight(width: labelWidth)
        descriptionLabel.frame.origin.x = titleLabel.frame.origin.x
        descriptionLabel.frame.origin.y = titleLabel.frame.maxY + NativeLayout.Spaces.step
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: descriptionLabel.frame.maxY + layoutMargins.bottom)
    }
    
    // MARK: - Actions
    
    func setProgress(_ value: CGFloat) {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .secondarySystemBackground.alpha(1 - value)
        }
    }
}
#endif
