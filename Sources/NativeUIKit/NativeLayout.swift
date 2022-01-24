// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS))
import UIKit

public enum NativeLayout {
    
    public enum Sizes {
        
        public static var actionable_area_maximum_width: CGFloat { 408 }
        public static var not_actionable_area_maximum_width: CGFloat { 382 }
    }
    
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
        
        public enum Scroll {
            
            public static var top_inset_transparent_navigation: CGFloat { step * 2 }
            public static var bottom_inset_reach_end: CGFloat { step * 9 }
            public static var bottom_inset_when_keyboard_can_appear: CGFloat { step * 8 }
        }
    }
}
#endif
