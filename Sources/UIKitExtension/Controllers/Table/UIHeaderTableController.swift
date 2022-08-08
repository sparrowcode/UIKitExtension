import UIKit
import DiffableKit

open class UIHeaderTableController: DiffableTableController {
    
    // MARK: - Public
    
    open func setHeaderView(_ view: UIView) {
        let headerContainerView = HeaderContainerView(contentView: view)
        headerContainerView.setWidthAndFit(width: self.view.frame.width)
        tableView.tableHeaderView = headerContainerView
    }
    
    open func setSpaceBetweenHeaderAndCells(_ value: CGFloat) {
        tableView.tableHeaderView?.layoutMargins.bottom = value
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerContainerView = tableView.tableHeaderView as? HeaderContainerView {
            
            if headerContainerView.contentView.layoutMargins.left != tableView.layoutMargins.left {
                headerContainerView.contentView.layoutMargins.left = tableView.layoutMargins.left
            }
            
            if headerContainerView.contentView.layoutMargins.right != tableView.layoutMargins.right {
                headerContainerView.contentView.layoutMargins.right = tableView.layoutMargins.right
            }
            
            headerContainerView.setWidthAndFit(width: view.frame.width)
            
            if cachedHeaderHeight != headerContainerView.frame.height {
                cachedHeaderHeight = headerContainerView.frame.height
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.diffableDataSource?.updateLayout(animated: true, completion: nil)
                }
            }
        }
    }
    
    private var cachedHeaderHeight: CGFloat? = nil
}
