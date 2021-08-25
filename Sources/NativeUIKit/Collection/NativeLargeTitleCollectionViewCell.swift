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

open class NativeLargeTitleCollectionViewCell: SPCollectionViewCell {
    
    // MARK: - Views
    
    public let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold, addPoints: .zero)
        if #available(iOS 13.0, *) {
            $0.textColor = .label
        } else {
            $0.textColor = .black
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        contentView.layoutMargins = .init(top: 32, left: .zero, bottom: 8, right: .zero)
        insetsLayoutMarginsFromSafeArea = false
        contentView.insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        contentView.preservesSuperviewLayoutMargins = false
        addSubview(titleLabel)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        var collectionView: UICollectionView?
        if let view = superview as? UICollectionView {
            collectionView = view
        }
        if let view = superview?.superview as? UICollectionView {
            collectionView = view
        }
        if let parent = collectionView {
            contentView.layoutMargins.left = parent.layoutMargins.left
            contentView.layoutMargins.right = parent.layoutMargins.right
        }
        titleLabel.layoutDynamicHeight(
            x: contentView.layoutMargins.left,
            y: contentView.layoutMargins.top,
            width: contentView.layoutWidth
        )
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: titleLabel.frame.maxY + contentView.layoutMargins.bottom)
    }
}
#endif
