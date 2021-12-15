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
import SPDiffable

@available(iOS 13.0, *)
extension NativeHeaderTableController {
    
    open class HeaderContainerView: SPView {
        
        // MARK: - Public
        
        public let contentView: UIView
        
        public var extendAreaToTop: Bool = true {
            didSet {
                extendAreaView.isHidden = !extendAreaToTop
            }
        }
        
        // MARK: - Private
        
        private var extendAreaView = SPView()
        
        // MARK: - Init
        
        public init(contentView: UIView) {
            self.contentView = contentView
            super.init()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func commonInit() {
            super.commonInit()
            insetsLayoutMarginsFromSafeArea = false
            layoutMargins = .zero
            addSubview(extendAreaView)
            addSubview(contentView)
        }
        
        // MARK: - Ovveride
        
        
        
        // MARK: - Layout
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            extendAreaView.frame = .init(x: .zero, maxY: .zero, width: frame.width, height: 1000)
            contentView.setWidthAndFit(width: layoutWidth)
            contentView.frame.origin.x = layoutMargins.left
            contentView.frame.origin.y = layoutMargins.top
        }
        
        public override func sizeThatFits(_ size: CGSize) -> CGSize {
            frame.setWidth(size.width)
            layoutSubviews()
            return .init(width: size.width, height: contentView.frame.maxY + layoutMargins.bottom)
        }
    }
}
#endif
