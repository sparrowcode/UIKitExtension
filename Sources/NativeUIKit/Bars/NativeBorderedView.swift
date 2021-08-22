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
import SparrowKit

/**
 NativeUIKit: View with porder on some position.
 For change position check property.
 */
open class NativeBorderedView: SPView {
    
    // MARK: - Data
    
    /**
     NativeUIKit: Border Position.
     */
    open var position: Position = .top {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: - Views
    
    private let borderView = SPView().do {
        if #available(iOS 13.0, *) {
            $0.backgroundColor = .separator
        } else {
            $0.backgroundColor = .systemGray
        }
    }
    
    // MARK: - Init
    
    public init(position: Position) {
        self.position = position
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func commonInit() {
        super.commonInit()
        addSubview(borderView)
    }
    
    // MARK: - Actions
    
    /**
     NativeUIKit: Show or hide border.
     
     - parameter visible: New visible state of border.
     - parameter animated: State for apply changes animatable or not.
     */
    open func setBorderVisible(_ visible: Bool, animated: Bool) {
        let work = { [weak self] in
            guard let self = self else { return }
            self.borderView.alpha = visible ? 1 : 0
        }
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                work()
            })
        } else {
            work()
        }
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        borderView.frame.setWidth(frame.width)
        borderView.frame.setHeight(0.5)
        borderView.frame.origin.x = 0
        switch position {
        case .top:
            borderView.frame.origin.y = 0
        case .bottom:
            borderView.frame.setMaxY(frame.height)
        }
    }
    
    // MARK: - Models
    
    public enum Position {
        
        case top
        case bottom
    }
}
#endif
