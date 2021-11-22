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
open class NativeHeaderTableController: SPDiffableTableController {
    
    // MARK: - Init
    
    public init(headerView: UIView, style: UITableView.Style) {
        super.init(style: style)
        tableView.tableHeaderView = HeaderContainerView(contentView: headerView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let headerView = tableView.tableHeaderView as? HeaderContainerView {
            headerView.setWidthAndFit(width: view.frame.width)
            if cachedHeaderHeight != headerView.frame.height {
                cachedHeaderHeight = headerView.frame.height
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let snapshot = self.diffableDataSource?.snapshot() else { return }
                    self.diffableDataSource?.apply(snapshot)
                }
            }
        }
    }
    
    private var cachedHeaderHeight: CGFloat? = nil
    
    // MARK: - Views
    
    class HeaderContainerView: SPView {
        
        let contentView: UIView
        
        init(contentView: UIView) {
            self.contentView = contentView
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func commonInit() {
            super.commonInit()
            insetsLayoutMarginsFromSafeArea = false
            layoutMargins = .zero
            addSubview(contentView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.setWidthAndFit(width: frame.width)
            contentView.frame.origin.x = .zero
            contentView.frame.origin.y = .zero
        }
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            frame.setWidth(size.width)
            layoutSubviews()
            return .init(width: size.width, height: contentView.frame.maxY)
        }
    }
}
#endif
