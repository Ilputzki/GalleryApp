import Foundation

final class GalleryPresenterImpl: GalleryPresenter {
    
    weak var view: GalleryView?
    private let imageManager: ImageManager
    private var pagesCount: Int = 1
    private let imagesPerPage: Int = 30
    
    private var galleryItems: [GalleryItem] = []
    
    init(view: GalleryView, imageManager: ImageManager) {
        self.view = view
        self.imageManager = imageManager
    }
    
    func getRows(at section: Int) -> Int {
        return galleryItems.count
    }
    
    func getGalleryItem(for indexPath: IndexPath) -> GalleryItem {
        return galleryItems[indexPath.row]
    }
    
    func fetchGalleryItems() {
        imageManager.fetchImages(page: pagesCount, limit: imagesPerPage) { items in
            self.galleryItems.append(contentsOf: items)
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        } galleryItemImageFetched: { item, image in
            item.previewImage = image
            item.downloadDate = Date()
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        } failure: { error in
            
        }
    }
    
    func scrolledToBottom() {
        pagesCount += 1
        fetchGalleryItems()
    }
}
