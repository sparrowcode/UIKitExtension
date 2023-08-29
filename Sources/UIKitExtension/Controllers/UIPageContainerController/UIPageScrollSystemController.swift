import UIKit

extension UIPageContainerController {
    
    class UIPageScrollSystemController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIPageContainerControllerInterface {
        
        private var childControllers: [UIViewController]? = nil
        private var controllersDataSource: UIPageContainerControllerDataSource?
        
        // MARK: - Init
        
        init(dataSource: UIPageContainerControllerDataSource, initialIndex: Int = .zero) {
            self.controllersDataSource = dataSource
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
            guard let firstController = getViewController(for: initialIndex) else { return }
            setViewControllers([firstController], direction: .forward, animated: false)
        }
        
        init(viewControllers: [UIViewController]) {
            self.childControllers = viewControllers
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
            guard let firstController = self.childControllers?.first else { return }
            setViewControllers([firstController], direction: .forward, animated: false)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            dataSource = self
            delegate = self
            
            view.layoutMargins = .zero
            view.preservesSuperviewLayoutMargins = true
            view.insetsLayoutMarginsFromSafeArea = false
            
            for view in view.subviews {
                if let scrollView = view as? UIScrollView {
                    scrollView.delaysContentTouches = false
                    scrollView.preservesSuperviewLayoutMargins = true
                }
            }
            
            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemBackground
            }
        }
        
        // MARK: - Layout
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // todo add observing margins for controllers
            /*let margins = view.layoutMargins
             childControllers.forEach({
             if $0.view.preservesSuperviewLayoutMargins && $0.view.layoutMargins != margins  {
             $0.view.layoutMargins = margins
             }
             })*/
        }
        
        // MARK: - SPPageControllerInterface
        
        // todo complete
        var allowScroll: Bool = false
        
        // todo complete
        func safeScrollTo(index: Int, animated: Bool) {
            guard let controller = getViewController(for: index) else { return }
            setViewControllers([controller], direction: .forward, animated: animated)
            
        }
        
        func getCurrentController() -> UIViewController? {
            return viewControllers?.first
        }
        
        // MARK: - UIPageViewControllerDataSource
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            if let childControllers = self.childControllers {
                guard let index = childControllers.firstIndex(of: viewController) else { return nil }
                let newIndex = index - 1
                if newIndex < 0 { return nil }
                return childControllers[newIndex]
            } else {
                print("vv \(viewController)")
                guard let currentIndex = (viewController as? UIPageContainerControllerIndexProtocol)?.pageControllerIndex else { fatalError() }
                return getViewController(for: currentIndex - 1)
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            if let childControllers = self.childControllers {
                guard let index = childControllers.firstIndex(of: viewController) else { return nil }
                let newIndex = index + 1
                if newIndex > childControllers.count - 1 { return nil }
                return childControllers[newIndex]
            } else {
                guard let indexBefore = (viewController as? UIPageContainerControllerIndexProtocol)?.pageControllerIndex else { fatalError() }
                print("currentIndex before \(indexBefore)")
                return getViewController(for: indexBefore + 1)
            }
        }
        
        // MARK: - Internal
        
        private func getViewController(for index: Int) -> UIViewController? {
            print("ask controller for index \(index) in page")
            guard let controller = controllersDataSource?.pageContainerViewController(for: index) else { return nil }
            guard var indexController = controller as? UIPageContainerControllerIndexProtocol else { fatalError() }
            indexController.pageControllerIndex = index
            return indexController as? UIViewController
        }
    }
}

public protocol UIPageContainerControllerIndexProtocol {
    
    var pageControllerIndex: Int? { get set }
}
