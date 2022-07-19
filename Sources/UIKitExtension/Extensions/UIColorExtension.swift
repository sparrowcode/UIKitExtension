#if canImport(UIKit)
import UIKit

extension UIColor {
    
    /**
     UIKitExtension: New color to system stack.
     Its color for empty areas and it usually downed of main background color.
     */
    public static var systemDownedBackground: UIColor {
        let lightColor = UIColor.secondarySystemBackground.mixWithColor(.darkGray, amount: 0.09).mixWithColor(UIColor.systemBlue, amount: 0.01)
        let darkColor = UIColor.secondarySystemBackground
        return UIColor.init(light: lightColor, dark: darkColor)
    }
    
    
    /**
     UIKitExtension: New color to system grouped stack.
     Its color for empty aread and it usually downed of content background color.
     */
    public static var systemDownedGroupedBackground: UIColor {
        return UIColor.init(dynamicProvider: { trait in
            if trait.userInterfaceStyle == .light {
                return UIColor.systemGroupedBackground.mixWithColor(.darkGray, amount: 0.09).mixWithColor(UIColor.systemBlue, amount: 0.01)
            } else {
                return UIColor.secondarySystemGroupedBackground.alpha(0.7)
            }
        })
    }
    
    /**
     UIKitExtension: Dimmed content color.
     */
    public static var dimmedContent: UIColor {
        return UIColor.secondaryLabel
    }
    
    /**
     UIKitExtension: Dimmed background color.
     */
    public static var dimmedBackground: UIColor {
        dimmedContent.alpha(0.1)
    }
}
#endif
