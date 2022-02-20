import UIKit

final class GalleryItemPresenterImpl: GalleryItemPresenter {
    
    // MARK: - Properties
    
    weak var view: GalleryItemView?
    private let galleryItem: GalleryItem
    
    // MARK: - Initializers
    
    init(view: GalleryItemView, item: GalleryItem) {
        self.view = view
        self.galleryItem = item
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        view?.setImage(galleryItem.previewImage)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateString = galleryItem.downloadDate != nil ? dateFormatter.string(from: galleryItem.downloadDate!) : nil
        view?.setNavigationItemTitle(dateString)
    }
    
    // MARK: - GalleryItemPresenter
    
    func imageFetched(_ image: UIImage) {
        view?.setImage(image)
    }
}
