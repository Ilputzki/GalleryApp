import UIKit

protocol GalleryItemPresenter {
    
    var view: GalleryItemView? { get set }
    
    func viewDidLoad()
    
    func imageFetched(_ image: UIImage)
}
