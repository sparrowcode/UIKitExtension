#if canImport(UIKit)
import UIKit

public extension UIImage {
    
    /**
     UIKitExtension: For iOS version get fill image, for macOS get lines images.
     */
    static func adaptive(_ name: String) -> UIImage {
        var formattedName = name
        let fillSuffix = ".fill"
        if UIDevice.current.isMac {
            if name.hasSuffix(fillSuffix) {
                formattedName = name.removedSuffix(fillSuffix)
            }
        } else {
            if !name.hasSuffix(fillSuffix) {
                formattedName = name + fillSuffix
            }
        }
        let image = UIImage.init(systemName: formattedName)
        return image ?? UIImage.system(name)
    }
}
#endif
