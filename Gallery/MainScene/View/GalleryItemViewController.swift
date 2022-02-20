import UIKit

class GalleryItemViewController: UIViewController, UIScrollViewDelegate, GalleryItemView {
    
    var presenter: GalleryItemPresenter?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        presenter?.viewDidLoad()
    }
    
    private func setUp() {
        scrollView.frame = view.frame
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.bounces = true
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setImage(_ image: UIImage?) {
        self.imageView.image = image
    }
}
