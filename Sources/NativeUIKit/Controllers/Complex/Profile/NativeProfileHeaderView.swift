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

@available(iOS 13.0, *)
open class NativeProfileHeaderView: SPView {
    
    // MARK: - Public
    
    public let avatarView = NativeAvatarView().do {
        $0.avatarAppearance = .placeholder
        $0.isEditable = true
    }
    
    public let nameLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold, addPoints: 2)
        $0.textColor = .label
        $0.numberOfLines = 1
        $0.textAlignment = .center
        // $0.adjustsFontSizeToFitWidth = true
        // $0.minimumScaleFactor = 0.5
        $0.text = nil
    }
    
    public let namePlaceholderLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title2, weight: .semibold, addPoints: 2)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
        $0.textAlignment = .center
        // $0.adjustsFontSizeToFitWidth = true
        // $0.minimumScaleFactor = 0.5
        $0.text = nil
    }
    
    // Add tap to clipboard
    public let emailButton = SPDimmedButton().do {
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular, addPoints: -2)
        // $0.titleLabel?.adjustsFontSizeToFitWidth = true
        // $0.titleLabel?.minimumScaleFactor = 0.5
        $0.titleImageInset = 2
    }
    
    // MARK: - Private
    
    private var extendView = SPView()
    
    var nameTextObserer: NSKeyValueObservation?
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        backgroundColor = .clear
        addSubviews([extendView, avatarView, nameLabel, namePlaceholderLabel, emailButton])
        
        layoutMargins = .init(
            top: NativeLayout.Spaces.default_half,
            left: NativeLayout.Spaces.default_double,
            bottom: NativeLayout.Spaces.default_half,
            right: NativeLayout.Spaces.default_double
        )
        
        self.nameLabel.isHidden = !(self.nameLabel == self.usingNameLabel)
        self.namePlaceholderLabel.isHidden = !(self.namePlaceholderLabel == self.usingNameLabel)
        
        nameTextObserer = nameLabel.observe(\.text) { [weak self] _, _ in
            guard let self = self else { return }
            self.nameLabel.isHidden = !(self.nameLabel == self.usingNameLabel)
            self.namePlaceholderLabel.isHidden = !(self.namePlaceholderLabel == self.usingNameLabel)
        }
    }
    
    // MARK: - Ovveride
    
    open override var backgroundColor: UIColor? {
        didSet {
            extendView.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Layout
    
    private var usingNameLabel: SPLabel {
        if nameLabel.text?.isEmptyContent ?? true {
            return namePlaceholderLabel
        } else {
            return nameLabel
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        extendView.frame = .init(x: .zero, maxY: .zero, width: frame.width, height: 1000)
        
        avatarView.sizeToFit()
        avatarView.setXCenter()
        avatarView.frame.origin.y = layoutMargins.top
        
        nameLabel.layoutDynamicHeight(width: layoutWidth)
        nameLabel.setXCenter()
        nameLabel.frame.origin.y = avatarView.frame.maxY + NativeLayout.Spaces.default_half
        
        namePlaceholderLabel.layoutDynamicHeight(width: layoutWidth)
        namePlaceholderLabel.setXCenter()
        namePlaceholderLabel.frame.origin.y = nameLabel.frame.origin.y
        
        emailButton.sizeToFit()
        emailButton.setXCenter()
        emailButton.frame.origin.y = usingNameLabel.frame.maxY
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: frame.width, height: emailButton.frame.maxY + layoutMargins.bottom)
    }
}
#endif
