#if canImport(UIKit) && (os(iOS))
import UIKit

public enum Layout {
    
    public enum Spaces {
        
        public static var step: CGFloat = 4
        
        public static var default_less: CGFloat { step * 3 }
        public static var `default`: CGFloat { step * 4 }
        public static var default_more: CGFloat { step * 5 }
        
        public static var default_half: CGFloat { self.default / 2 }
        public static var default_double: CGFloat { self.default * 2 }
        
        public enum Margins {
            
            public static var full_screen_horizontal: CGFloat { Spaces.default }
            public static var modal_screen_horizontal: CGFloat { step * 5 }
        }
    }
}
#endif
