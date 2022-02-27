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

open class NativeOnboardingActionsController: NativeHeaderController {
    
    private var views: [NativeOnbiardingActionButton] = []
    
    // MARK: - Init
    
    public init(
        iconImage: UIImage?,
        title: String,
        subtitle: String
    ) {
        super.init(image: iconImage, title: title, subtitle: subtitle)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        scrollView.addSubviews(views)
    }
    
    open func setActions(_ models: [NativeOnbiardingActionButton.ActionModel]) {
        // Clean old
        views.forEach({ $0.removeFromSuperview() })
        views.removeAll()
        
        // Add new
        views = models.map({ NativeOnbiardingActionButton(with: $0) })
        
        // Added like subviews
        if isViewLoaded {
            scrollView.addSubviews(views)
        }
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var currentYPosition = headerView.frame.maxY + NativeLayout.Spaces.default_double
        let elementWidth: CGFloat = min(scrollView.readableWidth, 320)
        for (_, itemView) in views.enumerated() {
            itemView.setWidthAndFit(width: elementWidth)
            itemView.setXCenter()
            itemView.frame.origin.y = currentYPosition
            currentYPosition = itemView.frame.maxY + NativeLayout.Spaces.default_half
        }
        scrollView.contentSize = .init(width: scrollView.frame.width, height: views.last?.frame.maxY ?? .zero)
    }
}
#endif
