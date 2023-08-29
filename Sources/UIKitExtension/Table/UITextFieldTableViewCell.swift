import UIKit
import DiffableKit

open class UITextFieldTableViewCell: UICommonTableViewCell {
    
    public static var reuseIdentifier: String { "UITextFieldTableViewCell" }
    
    public let titleLabel = UICommonLabel()
    public let textField = UICommonTextField()

    open override func commonInit() {
        super.commonInit()
        contentView.addSubviews(titleLabel, textField)
        selectionStyle = .none
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if titleLabel.text == nil {
            textField.setEqualSuperviewMarginsWithFrames()
        } else {
            titleLabel.sizeToFit()
            titleLabel.frame.origin.x = contentView.layoutMargins.left
            titleLabel.setYCenter()
            
            textField.sizeToFit()
            textField.setYCenter()
            let space: CGFloat = Spaces.default_half
            textField.frame.setWidth(contentView.layoutWidth - titleLabel.frame.maxX - space)
            textField.frame.origin.x = titleLabel.frame.maxX + space
        }
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        textField.text = nil
        textField.placeholder = nil
        textField.removeTargetsAndActions()
        accessoryView = nil
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}

extension DiffableTableDataSource.CellProvider {
    
    @available(iOS 14.0, *)
    public static var textField: DiffableTableDataSource.CellProvider  {
        return DiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let item = item as? DiffableTableTextField else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: UITextFieldTableViewCell.self, for: indexPath)
            cell.titleLabel.text = item.title
            cell.textField.text = item.getTextFieldText()
            cell.textField.placeholder = item.textFieldplaceholder
            cell.textField.addAction(.init(handler: { _ in
                item.action(item, indexPath, cell.textField.text)
            }), for: .editingChanged)
            return cell
        }
    }
}
