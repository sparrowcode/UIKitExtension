import UIKit
import DiffableKit

open class UIHeaderTableController: DiffableTableController {
    
    // MARK: - Public
    
    open func setHeaderView(_ view: UIView) {
        let containerView = HeaderContainerView(contentView: view)
        //headerContainerView.setWidthAndFit(width: self.view.frame.width)
        tableView.tableHeaderView = containerView
    }
    
    open func setFooterView(_ view: UIView) {
        let containerView = HeaderContainerView(contentView: view)
        //headerContainerView.setWidthAndFit(width: self.view.frame.width)
        tableView.tableFooterView = containerView
    }
    
    open func setSpaceBetweenHeaderAndCells(_ value: CGFloat) {
        tableView.tableHeaderView?.layoutMargins.bottom = value
    }
    
    open func setSpaceBetweenFooterAndCells(_ value: CGFloat) {
        tableView.tableFooterView?.layoutMargins.top = value
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in [tableView.tableHeaderView, tableView.tableFooterView] {
            if let containerView = view as? HeaderContainerView {
                if containerView.layoutMargins.left != tableView.layoutMargins.left {
                    containerView.layoutMargins.left = tableView.layoutMargins.left
                }
                
                if containerView.layoutMargins.right != tableView.layoutMargins.right {
                    containerView.layoutMargins.right = tableView.layoutMargins.right
                }
                
                containerView.setWidthAndFit(width: self.view.frame.width)
                
                if view == tableView.tableHeaderView && cachedHeaderHeight != containerView.frame.height  {
                    let animated = (cachedHeaderHeight == nil) ? false : true
                    cachedHeaderHeight = containerView.frame.height
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.diffableDataSource?.updateLayout(animated: animated, completion: nil)
                    }
                }
                
                if view == tableView.tableFooterView && cachedFooterHeight != containerView.frame.height  {
                    let animated = (cachedHeaderHeight == nil) ? false : true
                    cachedFooterHeight = containerView.frame.height
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.diffableDataSource?.updateLayout(animated: animated, completion: nil)
                    }
                }
            }
        }
        
    }
    
    private var cachedHeaderHeight: CGFloat? = nil
    private var cachedFooterHeight: CGFloat? = nil
}
