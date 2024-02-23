#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class UILargeHeaderTableView: UICommonTableViewHeaderFooterView {
    
    public let headerView = UILargeHeaderView()
    
    open override func commonInit() {
        super.commonInit()
        insetsLayoutMarginsFromSafeArea = false
        contentView.layoutMargins = .zero
        contentView.layoutMargins.left = Spaces.default_half
        contentView.preservesSuperviewLayoutMargins = false
        contentView.insetsLayoutMarginsFromSafeArea = false
        contentView.addSubview(headerView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        headerView.setWidthAndFit(width: contentView.layoutWidth)
        headerView.frame.origin = .init(x: contentView.layoutMargins.left, y: contentView.layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return .init(width: superSize.width, height: headerView.frame.maxY + contentView.layoutMargins.bottom)
    }
}

extension DiffableTableDataSource.HeaderFooterProvider {
    
    public static var largeHeader: DiffableTableDataSource.HeaderFooterProvider  {
        return DiffableTableDataSource.HeaderFooterProvider() { (tableView, section, item) -> UIView? in
            guard let header = item as? DiffableLargeHeaderItem else { return nil }
            let view = tableView.dequeueReusableHeaderFooterView(withClass: UILargeHeaderTableView.self)
            view.headerView.button.setTitle(header.title)
            view.headerView.button.addAction(.init(handler: { _ in
                header.action?(item, .init(row: .zero, section: section))
            }), for: .touchUpInside)
            return view
        }
    }
}
#endif
