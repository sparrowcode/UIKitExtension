import UIKit

protocol UIPageContainerControllerInterface: AnyObject {
    
    var allowScroll: Bool { get set }

    func safeScrollTo(index: Int, animated: Bool)
}
