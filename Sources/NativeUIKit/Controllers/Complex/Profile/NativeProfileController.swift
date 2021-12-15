#if canImport(UIKit) && (os(iOS))
import UIKit
import SparrowKit
import SPDiffable

@available(iOS 13.0, *)
open class NativeProfileController: NativeHeaderTableController {

    // MARK: - Views
    
    public let headerView = NativeProfileHeaderView()
    
    // MARK: - Init
    
    public init() {
        super.init(style: .insetGrouped, headerView: headerView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .empty
    }
    
    // MARK: - Public
    
    open func setSpaceBetweenHeaderAndCells(_ value: CGFloat) {
        headerContainerView.layoutMargins.bottom = value
    }
}
#endif
