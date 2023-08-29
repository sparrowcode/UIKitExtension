#if canImport(UIKit) && (os(iOS))
import UIKit
import DiffableKit
import SwiftBoost

open class UILargeHeaderCollectionView: UICommonCollectionReusableView {
    
    public let headerView = UILargeHeaderView()
    
    open override func commonInit() {
        super.commonInit()
        layoutMargins = .zero
        layoutMargins.left = Spaces.default_half
        preservesSuperviewLayoutMargins = false
        insetsLayoutMarginsFromSafeArea = false
        addSubview(headerView)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        headerView.button.removeTargetsAndActions()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        headerView.setWidthAndFit(width: layoutWidth)
        headerView.frame.origin = .init(x: layoutMargins.left, y: layoutMargins.top)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        layoutSubviews()
        return .init(width: superSize.width, height: headerView.frame.maxY + layoutMargins.bottom)
    }
}

extension DiffableCollectionDataSource.HeaderFooterProvider {
    
    public static var largeHeader: DiffableCollectionDataSource.HeaderFooterProvider  {
        return DiffableCollectionDataSource.HeaderFooterProvider() { (collectionView, section, item) -> UICollectionReusableView? in
            guard let header = item as? DiffableLargeHeaderItem else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(withCalss: UILargeHeaderCollectionView.self, kind: UICollectionView.elementKindSectionHeader, for: .init(row: .zero, section: section))
            view.headerView.button.setTitle(header.title)
            if #available(iOS 14.0, *) {
                if let action = header.action {
                    view.headerView.showChevron = true
                    view.headerView.button.addAction(.init(handler: { _ in
                        action(item, .init(row: .zero, section: section))
                    }), for: .touchUpInside)
                } else {
                    view.headerView.showChevron = true
                }
            } else {
                #warning("add for ios 13")
                view.headerView.showChevron = false
            }
            view.layoutSubviews()
            return view
        }
    }
}
#endif
