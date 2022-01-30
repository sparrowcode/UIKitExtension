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

open class NativeOnboardingFeaturesController: NativeHeaderController {
    
    private var views: [NativeOnboardingFeatureView] = []
    
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
    
    open func setFeatures(_ models: [NativeOnboardingFeatureView.FeatureModel]) {
        // Clean old
        views.forEach({ $0.removeFromSuperview() })
        views.removeAll()
        
        // Add new
        views = models.map({ NativeOnboardingFeatureView(with: $0) })
        
        // Added like subviews
        if isViewLoaded {
            scrollView.addSubviews(views)
        }
    }
    
    // MARK: - Layout
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var currentYPosition = headerView.frame.maxY + NativeLayout.Spaces.default_double
        for (_, itemView) in views.enumerated() {
            itemView.setWidthAndFit(width: scrollView.readableWidth)
            itemView.setXCenter()
            itemView.frame.origin.y = currentYPosition
            currentYPosition = itemView.frame.maxY + NativeLayout.Spaces.default_half
        }
        scrollView.contentSize = .init(width: scrollView.frame.width, height: views.last?.frame.maxY ?? .zero)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for itemView in views {
            let progress = progressForFeatureView(itemView)
            itemView.setProgress(progress)
        }
    }
    
    private func progressForFeatureView(_ view: NativeOnboardingFeatureView) -> CGFloat {
        let offsetY = scrollView.contentOffset.y + scrollView.safeAreaInsets.top + scrollView.frame.height - scrollView.safeAreaInsets.bottom
        let correction: CGFloat = NativeLayout.Spaces.Scroll.bottom_inset_reach_end
        let topSafeArea = scrollView.safeAreaInsets.top + correction
        let startPosition = view.frame.origin.y + topSafeArea
        let progress = (offsetY - startPosition) / view.frame.height
        if progress < .zero { return .zero }
        if progress > 1 { return 1 }
        return progress
    }
}
#endif
