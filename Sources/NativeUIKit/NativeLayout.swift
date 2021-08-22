import UIKit

enum NativeLayout {
    
    enum Sizes {
        
        static var actionable_area_maximum_width: CGFloat { 408 }
        static var not_actionable_area_maximum_width: CGFloat { 382 }
    }
    
    enum Spaces {
        
        enum Scroll {
            
            static var bottom_inset_reach_end: CGFloat { 36 }
            static var bottom_inset_when_keyboard_can_appear: CGFloat { 32 }
        }
    }
}
