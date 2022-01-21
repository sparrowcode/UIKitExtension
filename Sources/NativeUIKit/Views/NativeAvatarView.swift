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
 NativeUIKit: Native avatar view.
 
 Using SFSymbols for content.
 You  shoud update avatar by set `avatarAppearance` to valid state.
 For change colors or content check images and colorises properties.
 For change show edit button set `isEditable` to true.
 */
@available(iOS 13, *)
open class NativeAvatarView: SPView {
    
    // MARK: - Views
    
    public lazy var activityIndicatorView = UIActivityIndicatorView().do {
        $0.stopAnimating()
    }
    
    public lazy var avatarButton = SPButton().do {
        $0.imageView?.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    public lazy var placeholderButton = SPDimmedButton().do {
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(placeholderImage)
        $0.applyDefaultAppearance(with: placeholderColorise)
    }
    
    public lazy var indicatorButton = SPDimmedButton().do {
        $0.contentEdgeInsets = .init(side: 4)
    }
    
    // MARK: - Data
    
    /**
     NativeUIKit: Indicate if current state has avatar.
     */
    open var hasAvatar: Bool {
        switch avatarAppearance {
        case .avatar(_): return true
        default: return false
        }
    }
    
    /**
     NativeUIKit: Appearance of avatar button. Can be placeholder or with content.
     State loading show loading indicator and hide all other views.
     */
    open var avatarAppearance: AvatarAppearance = .placeholder {
        didSet {
            updateAvatarAppearance()
            updateEditAppearance()
        }
    }
    
    /**
     NativeUIKit: Hidden or visible edit button.
     */
    open var isEditable: Bool = false {
        didSet {
            updateEditAppearance()
        }
    }
    
    open var placeholderImage = UIImage.system("person.crop.circle.fill", font: .systemFont(ofSize: 80, weight: .medium))
    open var placeholderColorise = SPDimmedButton.Colorise.init(content: .init(light: .systemGray3, dark: .systemGray2), background: .clear)
    open var indicatorAddImage = UIImage.system("plus", font: .preferredFont(forTextStyle: .title3, weight: .bold))
    open var indicatorAddColorise = SPDimmedButton.Colorise.init(content: .white, background: .systemGreen)
    open var indicatorEditImage = UIImage.system("pencil", font: .preferredFont(forTextStyle: .title3, weight: .bold))
    open var indicatorEditColorise = SPDimmedButton.Colorise.init(content: .white, background: .systemBlue)
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        addSubview(placeholderButton)
        addSubview(avatarButton)
        addSubview(indicatorButton)
        addSubview(activityIndicatorView)
        updateAvatarAppearance()
        updateEditAppearance()
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderButton.frame = .init(side: layoutWidth)
        placeholderButton.frame.origin.y = layoutMargins.top
        placeholderButton.center.x = frame.width / 2
        
        let avatarSideSize = min(placeholderButton.frame.width, placeholderButton.frame.height) * 0.93
        avatarButton.frame = .init(side: avatarSideSize)
        avatarButton.center = placeholderButton.center
        avatarButton.roundMinimumSide()
        indicatorButton.sizeToFit()
        indicatorButton.roundMinimumSide()
        let sqrt2 = CGFloat(sqrt(2))
        let indicatorCenter = ((avatarButton.frame.width * (sqrt2 + 1)) / (2 * sqrt2)) * 1.02
        indicatorButton.center = .init(x: indicatorCenter, y: indicatorCenter)
        
        activityIndicatorView.center = placeholderButton.center
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        placeholderButton.sizeToFit()
        frame.setWidth(placeholderButton.frame.width + layoutMargins.left + layoutMargins.right)
        layoutSubviews()
        return .init(
            width: max(placeholderButton.frame.maxX, indicatorButton.frame.maxX) + layoutMargins.bottom,
            height: max(placeholderButton.frame.maxY, indicatorButton.frame.maxY) + layoutMargins.bottom
        )
    }
    
    // MARK: - Internal
    
    /**
     NativeUIKit: Call for update to current avatar appearance.
     */
    internal func updateAvatarAppearance() {
        switch avatarAppearance {
        case .loading:
            activityIndicatorView.startAnimating()
            avatarButton.isHidden = true
            placeholderButton.isHidden = true
        case .placeholder:
            activityIndicatorView.stopAnimating()
            avatarButton.isHidden = true
            placeholderButton.isHidden = false
        case .avatar(let image):
            activityIndicatorView.stopAnimating()
            avatarButton.isHidden = false
            avatarButton.setImage(image)
            placeholderButton.isHidden = true
        }
    }
    
    /**
     NativeUIKit: Call for update to current edit appearance.
     */
    internal func updateEditAppearance() {
        if isEditable {
            switch avatarAppearance {
            case .loading:
                indicatorButton.isHidden = true
            case .placeholder:
                indicatorButton.isHidden = false
                indicatorButton.setImage(indicatorAddImage)
                indicatorButton.applyDefaultAppearance(with: indicatorAddColorise)
            case .avatar(_):
                indicatorButton.isHidden = false
                indicatorButton.setImage(indicatorEditImage)
                indicatorButton.applyDefaultAppearance(with: indicatorEditColorise)
            }
        } else {
            indicatorButton.isHidden = true
        }
        
        [placeholderButton, avatarButton, indicatorButton].forEach({ $0.isUserInteractionEnabled = isEditable })
    }
    
    // MARK: - Models
    
    /**
     NativeUIKit: Appearance states for avatar view.
     */
    public enum AvatarAppearance {
        
        case loading
        case placeholder
        case avatar(_ image: UIImage)
    }
    
    /**
     NativeUIKit: Appearance states for edit button.
     */
    public enum EditAppearance {
        
        case none
        case edit
        case add
    }
}
#endif
