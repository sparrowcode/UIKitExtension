#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit

open class DiffableTableTextField: DiffableItem {
    
    open var title: String? = nil
    open var getTextFieldText: (() -> String?) = { return nil }
    open var textFieldplaceholder: String? = nil
    open var action: Action
    
    public init(
        id: String,
        title: String?,
        getTextFieldText: @escaping (() -> String?),
        textFieldplaceholder: String?,
        action: @escaping Action
    ) {
        self.title = title
        self.getTextFieldText = getTextFieldText
        self.textFieldplaceholder = textFieldplaceholder
        self.action = action
        super.init(id: id)
    }
    
    open override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        return hasher.finalize()
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? DiffableItem else { return false }
        return id == object.id
    }
    
    public typealias Action = (_ item: DiffableItem, _ indexPath: IndexPath, _ value: String?) -> Void
}
#endif
