import UIKit

extension NativeLargeHeaderView {
    
    func configure(with item: NativeLargeHeaderItem, section: Int) {
        titleLabel.text = item.title
        if let actionTitle = item.actionTitle {
            button.setTitle(actionTitle)
            diffableButtonAction = {
                item.action?(item, .init(row: .zero, section: section))
            }
        }
    }
}
