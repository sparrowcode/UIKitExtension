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

@available(iOS 13, *)
open class NativePlayPauseCompactButton: SPDimmedButton {
    
    // MARK: - Data
    
    open var appearance: Appearance = .play {
        didSet {
            updateAppearance()
        }
    }
    open var playImage = UIImage.system("play.fill", font: .preferredFont(forTextStyle: .body))
    open var pauseImage = UIImage.system("pause.fill", font: .preferredFont(forTextStyle: .body))
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        contentEdgeInsets = .init(side: 8)
        applyDefaultAppearance(with: .init(content: .tint, background: .custom(.clear)))
        updateAppearance()
    }
    
    // MARK: - Internal
    
    internal func updateAppearance() {
        switch self.appearance {
        case .play:
            setImage(playImage)
        case .pause:
            setImage(pauseImage)
        }
    }
    
    // MARK: - Models
    
    public enum Appearance {
        
        case play
        case pause
    }
}
#endif
