import UIKit

/**
 - warning: Sometimes scroll working not well. Recommended to use composition layout.
 */
open class UIPagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public enum Behavior {
        
        case soft
        case aggresive
    }
    
    open var behavior: Behavior = .soft
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        switch behavior {
        case .soft:
            guard let collectionView = self.collectionView else {
                let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
                return latestOffset
            }
            var offsetAdjustment = CGFloat.greatestFiniteMagnitude
            let horizontalOffset = proposedContentOffset.x
            let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: collectionView.bounds.size)
            for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
                let itemOffset = layoutAttributes.frame.origin.x
                if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
                    offsetAdjustment = itemOffset - horizontalOffset
                }
            }
            return CGPoint(x: proposedContentOffset.x + offsetAdjustment - collectionView.layoutMargins.left, y: proposedContentOffset.y)
        case .aggresive:
            guard let collectionView = self.collectionView else {
                let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
                return latestOffset
            }
            let pageWidth = self.itemSize.width + self.minimumLineSpacing
            let approximatePage = collectionView.contentOffset.x / pageWidth
            let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))
            let flickVelocity = velocity.x * 0.3
            let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
            let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left
            return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
        }
    }
}
