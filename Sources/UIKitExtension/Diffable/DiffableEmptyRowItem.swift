#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class DiffableEmptyRowItem: DiffableTableRow {
    
    var verticalMargins: UIEmptyTableViewCell.Margins
    
    public init(id: String, verticalMargins: UIEmptyTableViewCell.Margins, text: String, detail: String?) {
        self.verticalMargins = verticalMargins
        super.init(id: id, text: text, detail: detail)
    }
}

extension DiffableTableDataSource.CellProvider {
    
    public static var empty: DiffableTableDataSource.CellProvider  {
        return DiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let item = item as? DiffableEmptyRowItem else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: UIEmptyTableViewCell.self, for: indexPath)
            cell.placeholderView.headerLabel.text = item.text
            cell.placeholderView.descriptionLabel.text = item.detail
            cell.verticalMargins = item.verticalMargins
            return cell
        }
    }
}
#endif
