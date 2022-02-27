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

public class NativeOnbiardingActionButton: SPDimmedButton {
    
    // MARK: - Data
    
    private let model: ActionModel
    
    // MARK: - Views
    
    let disclouserIndicator = SPDimmedButton().do {
        if #available(iOS 13, *) {
            $0.setImage(.system("chevron.right", font: .preferredFont(forTextStyle: .body, weight: .medium)).alwaysTemplate)
            $0.tintColor = .tertiaryLabel
        }
    }
    
    let actionIconView = SPImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    let actionTitleLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .body, weight: .semibold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
        $0.numberOfLines = .zero
    }
    
    let actionDescriptionLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .subheadline)
        if #available(iOS 13.0, *) {
            $0.textColor = .secondaryLabel
        } else {
            $0.textColor = .black
        }
        $0.numberOfLines = .zero
    }
    
    // MARK: - Init
    
    init(with model: ActionModel) {
        self.model = model
        super.init()
        actionIconView.image = model.iconImage
        actionTitleLabel.text = model.title
        actionDescriptionLabel.text = model.description
        
        addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func commonInit() {
        super.commonInit()
        higlightStyle = .background
        if #available(iOS 13.0, *) {
            applyDefaultAppearance(with: .init(content: .label, background: .secondarySystemBackground))
        }
        roundCorners(radius: NativeLayout.Spaces.default_less)
        layoutMargins = .init(horizontal: NativeLayout.Spaces.default_more, vertical: NativeLayout.Spaces.default_more)
        addSubviews(actionIconView, actionTitleLabel, actionDescriptionLabel, disclouserIndicator)
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        actionIconView.frame = .init(side: 28)
        actionIconView.frame.origin.x = layoutMargins.left
        
        disclouserIndicator.sizeToFit()
        disclouserIndicator.setMaxXToSuperviewRightMargin()
        
        let leftSpace: CGFloat = NativeLayout.Spaces.default_more
        let rightSpace: CGFloat = NativeLayout.Spaces.default
        let labelWidth = layoutWidth - actionIconView.frame.width - disclouserIndicator.frame.width - leftSpace - rightSpace
        
        actionTitleLabel.layoutDynamicHeight(width: labelWidth)
        actionTitleLabel.frame.origin.x = actionIconView.frame.maxX + leftSpace
        actionTitleLabel.frame.origin.y = layoutMargins.top
        
        actionDescriptionLabel.layoutDynamicHeight(width: labelWidth)
        actionDescriptionLabel.frame.origin.x = actionTitleLabel.frame.origin.x
        actionDescriptionLabel.frame.origin.y = actionTitleLabel.frame.maxY + NativeLayout.Spaces.step
        
        disclouserIndicator.setYCenter()
        actionIconView.setYCenter()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: actionDescriptionLabel.frame.maxY + layoutMargins.bottom)
    }
    
    // MARK: - Action
    
    @objc func didTap() {
        self.model.action()
    }
    
    // MARK: - Models
    
    /**
     Wrapper of data for action model.
     
     - important: Recomended save app tint color for icons like native.
     */
    public class ActionModel {
        
        let iconImage: UIImage
        let title: String
        let description: String
        let action: ()->Void
        
        public init(iconImage: UIImage, title: String, description: String, action: @escaping ()->Void) {
            self.iconImage = iconImage
            self.title = title
            self.description = description
            self.action = action
        }
    }
}
#endif
