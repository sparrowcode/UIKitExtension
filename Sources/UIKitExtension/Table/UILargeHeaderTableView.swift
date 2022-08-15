#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class UILargeHeaderTableView: UICommonTableViewHeaderFooterView {
    
    public let headerView = UILargeHeaderView()
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        contentView.layoutMargins = .zero
        contentView.addSubview(headerView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        headerView.setWidthAndFit(width: contentView.layoutWidth)
        headerView.frame.origin = .init(x: contentView.layoutMargins.left, y: layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return .init(width: superSize.width, height: headerView.frame.height + layoutMargins.bottom)
    }
}

// MARK: - Diffable

open class DiffableLargeHeaderItem: DiffableActionableItem {
    
    open var title: String
    open var actionTitle: String?
    
    public init(id: String? = nil, title: String, actionTitle: String? = nil, action: Action? = nil) {
        self.title = title
        self.actionTitle = actionTitle
        super.init(id: id ?? title, action: action)
    }
}

extension DiffableTableDataSource.HeaderFooterProvider {
    
    public static var largeHeader: DiffableTableDataSource.HeaderFooterProvider  {
        return DiffableTableDataSource.HeaderFooterProvider() { (tableView, section, item) -> UIView? in
            guard let header = item as? DiffableLargeHeaderItem else { return nil }
            let view = tableView.dequeueReusableHeaderFooterView(withClass: UILargeHeaderTableView.self)
            view.headerView.titleLabel.text = header.title
            if let actionTitle = header.actionTitle {
                view.headerView.button.setTitle(actionTitle)
                view.headerView.diffableButtonAction = {
                    header.action?(item, .init(row: .zero, section: section))
                }
            }
            return view
        }
    }
}
#endif
