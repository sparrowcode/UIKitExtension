import UIKit

open class UICommonCollectionViewContoller: UICollectionViewController, UICommonInit {
    
    // MARK: - Init
    
    public convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        commonInit()
    }
    
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {}
}
