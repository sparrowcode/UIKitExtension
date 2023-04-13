#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class DiffableLargeHeaderItem: DiffableActionableItem {
    
    open var title: String
    
    public init(id: String? = nil, title: String, action: Action? = nil) {
        self.title = title
        super.init(id: id ?? title, action: action)
    }
}
#endif
