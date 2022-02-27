// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.io)
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

open class NativeHeaderTextFieldController: NativeHeaderController {
    
    // MARK: - Views
    
    public let textField = NativeLargeTextField().do {
        $0.returnKeyType = .done
        $0.autocapitalizationType = .words
    }
    
    public let footerView = NativeFooterView()
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        scrollView.addSubviews(textField, footerView)
        dismissKeyboardWhenTappedAround()
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.layout(y: headerView.frame.maxY + NativeLayout.Spaces.default + NativeLayout.Spaces.default_half)
        footerView.setWidthAndFit(width: textField.frame.width)
        footerView.frame.origin.x = textField.frame.origin.x
        footerView.frame.origin.y = textField.frame.maxY
        scrollView.contentSize = .init(width: view.frame.width, height: footerView.frame.maxY)
    }
}
#endif
