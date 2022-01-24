import UIKit

extension NativeLargeHeaderView {
    
    open func configure(with item: NativeLargeHeaderItem) {
        titleLabel.text = item.title
        if let actionTitle = item.actionTitle {
            button.setTitle(actionTitle)
        }
    }
}
