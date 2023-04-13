import UIKit

open class UIPageContainerController: UIViewController {
    
    public var containerController: UIViewController
    
    // todo clean to
    
    public func scrollToPage(index: Int) {
        if let pageController = containerController as? UIPageScrollSystemController {
            pageController.safeScrollTo(index: index, animated: true)
        }
    }
    
    public init(data: UIPageContainerControllerDataSystem, scrollSystem: UIPageContainerControllerScrollSystem) {
        switch data {
        case .dataSource(let dataSource):
            switch scrollSystem {
            case .page:
                containerController = UIPageScrollSystemController(dataSource: dataSource)
            case .scroll:
                fatalError()
            }
        case .array(let viewControllers):
            switch scrollSystem {
            case .page:
                containerController = UIPageScrollSystemController(viewControllers: viewControllers)
            case .scroll:
                fatalError()
            }
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //presentationController?.delegate = self
        
        containerController.view.backgroundColor = .clear
        addChild(containerController)
        view.addSubview(containerController.view)
        containerController.didMove(toParent: self)
        
        containerController.view.preservesSuperviewLayoutMargins = true
        containerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerController.view.topAnchor.constraint(equalTo: view.topAnchor),
            containerController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

public enum UIPageContainerControllerScrollSystem {
    
    case page
    case scroll
}

public protocol UIPageContainerControllerDataSource {
    
    func pageContainerViewController(for index: Int) -> UIViewController?
}

public enum UIPageContainerControllerDataSystem {
    
    case dataSource(dataSource: UIPageContainerControllerDataSource)
    case array(viewControllers: [UIViewController])
}
