import UIKit
import DiffableKit

open class UITintedTableViewCell: DiffableTableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .medium)
        selectionStyle = .none
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        for view in [imageView, textLabel] {
            #warning("to constant higloight 0.7")
            view?.alpha = highlighted ? 0.7 : 1
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return .init(width: superSize.width, height: superSize.height + 4)
    }
}

extension DiffableTableDataSource.CellProvider {
    
    public static var rowTinted: DiffableTableDataSource.CellProvider  {
        return DiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let item = item as? DiffableTintedTableRow else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: UITintedTableViewCell.self, for: indexPath)
            cell.textLabel?.text = item.text
            cell.detailTextLabel?.text = item.detail
            cell.imageView?.image = item.icon
            cell.accessoryType = item.accessoryType
            cell.imageView?.tintColor = item.color
            cell.textLabel?.textColor = item.color
            return cell
        }
    }
}
