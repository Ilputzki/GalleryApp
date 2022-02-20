import UIKit

class GalleryItemViewController: UIViewController, UIScrollViewDelegate, GalleryItemView {
    
    // MARK: - Properties
    
    var presenter: GalleryItemPresenter?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Methods
    
    private func setUp() {
        scrollView.frame = view.frame
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.bounces = true
        scrollView.delegate = self
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - GalleryItemView
    
    func setImage(_ image: UIImage?) {
        self.imageView.image = image
    }
    
    func setNavigationItemTitle(_ title: String?) {
        navigationItem.title = title
    }
}
