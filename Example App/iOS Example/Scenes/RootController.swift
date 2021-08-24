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

import UIKit
import SparrowKit
import NativeUIKit

class RootController: SPController {
    
    let largeButton = NativeLargeActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(largeButton)
        largeButton.applyDefaultAppearance(with: .init(content: .custom(.white), background: .tint))
        largeButton.setTitle("Title")
        
        largeButton.addAction(.init(handler: { _ in
            let controller = Native2HeaderController(image: nil, title: "Title", subtitle: "Subtitle")
            let toolBarView = NativeSkipableLargeActionToolBarView()
            toolBarView.actionButton.setTitle("Action Button")
            toolBarView.skipButton.setTitle("Skip")
            controller.toolBarView = toolBarView
            let navController = controller.wrapToNavigationController(prefersLargeTitles: false)
            controller.navigationItem.title = "Navigation Item"
            self.present(navController)
        }), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        largeButton.sizeToFit()
        largeButton.frame.setWidth(view.layoutWidth)
        largeButton.setXCenter()
        largeButton.frame.origin.y = 200
        
    }
}

class Native2HeaderController: NativeHeaderController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = .init(width: view.frame.width, height: 1400)
    }
}
