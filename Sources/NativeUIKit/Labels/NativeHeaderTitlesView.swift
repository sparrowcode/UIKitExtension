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
 */
open class NativeHeaderTitlesView: SPView {
    
    // MARK: - Views
    
    open var titleLabel = SPLabel().do {
        $0.numberOfLines = .zero
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle, weight: .bold)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
        $0.textAlignment = .center
    }
    
    open var subtitleLabel = SPLabel().do {
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
    
    public init(title: String, subtitle: String) {
        super.init()
        titleLabel.text = title
        subtitleLabel.text = subtitle
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
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.layoutDynamicHeight(x: .zero, y: layoutMargins.top, width: layoutWidth)
        subtitleLabel.layoutDynamicHeight(x: .zero, y: titleLabel.frame.maxY + 4, width: titleLabel.frame.width)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        let newWidth = min(superSize.width, 408)
        frame.setWidth(newWidth)
        layoutSubviews()
        return .init(width: newWidth, height: subtitleLabel.frame.maxY + layoutMargins.bottom)
    }
}
#endif
