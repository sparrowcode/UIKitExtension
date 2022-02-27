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

@available(iOS 13.0, *)
open class NativeHeaderFullWidthImageController: SPScrollController {
    
    // MARK: - Views

    public let headerImageView = SPImageView().do {
        $0.backgroundColor = .systemGray.alpha(0.1)
        $0.contentMode = .scaleAspectFill
    }
    
    public let titlesView = NativeModalHeaderView()
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews([headerImageView, titlesView])
        navigationController?.navigationBar.setAppearance(.transparentAlways)
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerImageView.frame = .init(x: .zero, y: -scrollView.layoutMargins.top, width: view.frame.width, height: view.frame.height * 0.45)
        titlesView.layout(y: headerImageView.frame.maxY + NativeLayout.Spaces.default_double)
        scrollView.contentSize = .init(
            width: view.frame.width,
            height: titlesView.frame.maxY + NativeLayout.Spaces.default_double
        )
    }
}
#endif
