import UIKit

open class UICommonScrollViewController: UICommonViewContoller {
    
    public lazy var scrollView = UICommonScrollView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delaysContentTouches = false
        view.addSubview(scrollView)
        
        if #available(iOS 15.0, *) {
            setContentScrollView(scrollView)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}