#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class DiffableTintedTableRow: DiffableTableRow {
    
    open var color: UIColor
    
    public init(
        id: String? = nil,
        text: String,
        detail: String? = nil,
        icon: UIImage? = nil,
        color: UIColor,
        accessoryType: UITableViewCell.AccessoryType = .none,
        action: Action? = nil
    ) {
        self.color = color
        super.init(id: id ?? text, text: text, detail: detail, icon: icon, accessoryType: accessoryType, selectionStyle: .none, action: action)
    }
}
#endif
