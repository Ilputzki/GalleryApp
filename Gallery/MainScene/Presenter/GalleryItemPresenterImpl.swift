import UIKit

final class GalleryItemPresenterImpl: GalleryItemPresenter {
    
    weak var view: GalleryItemView?
    private let galleryItem: GalleryItem
    
    init(view: GalleryItemView, item: GalleryItem) {
        self.view = view
        self.galleryItem = item
    }
    
    func viewDidLoad() {
        view?.setImage(galleryItem.previewImage)
    }
    
    func imageFetched(_ image: UIImage) {
        view?.setImage(image)
    }
}
