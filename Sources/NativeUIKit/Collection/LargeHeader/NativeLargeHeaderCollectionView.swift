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

import UIKit
import SparrowKit

open class NativeLargeHeaderCollectionView: SPCollectionReusableView {
    
    public let headerView = NativeLargeHeaderView()
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        layoutMargins = .zero
        addSubview(headerView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        headerView.layout(y: layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return .init(width: superSize.width, height: headerView.frame.height + layoutMargins.bottom)
    }
    
    static public func size(for item: NativeLargeHeaderItem, in collectionView: UICollectionView) -> CGSize {
        let view = NativeLargeHeaderView()
        view.configure(with: item)
        view.setWidthAndFit(width: collectionView.layoutWidth)
        return .init(width: collectionView.frame.width, height: view.frame.height)
    }
}
