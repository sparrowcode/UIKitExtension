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

    // MARK: - Public
    
    open var headerContainerView: HeaderContainerView
    
    // MARK: - Init
    
    public init(style: UITableView.Style, headerView: UIView) {
        self.headerContainerView = HeaderContainerView(contentView: headerView)
        super.init(style: style)
        headerContainerView.setWidthAndFit(width: view.frame.width)
        tableView.tableHeaderView = headerContainerView
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerContainerView.contentView.layoutMargins.left = tableView.layoutMargins.left
        headerContainerView.contentView.layoutMargins.right = tableView.layoutMargins.right
        headerContainerView.setWidthAndFit(width: view.frame.width)
        if cachedHeaderHeight != headerContainerView.frame.height {
            cachedHeaderHeight = headerContainerView.frame.height
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let snapshot = self.diffableDataSource?.snapshot() else { return }
                self.diffableDataSource?.apply(snapshot)
            }
        }
    }
    
    private var cachedHeaderHeight: CGFloat? = nil
    
    // MARK: - Public
    
    open func setSpaceBetweenHeaderAndCells(_ value: CGFloat) {
        headerContainerView.layoutMargins.bottom = value
    }
}
#endif
