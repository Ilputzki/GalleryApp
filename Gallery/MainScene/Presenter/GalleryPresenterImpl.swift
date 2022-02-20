import UIKit

final class GalleryPresenterImpl: GalleryPresenter {
    
    // MARK: - Properties
    
    weak var view: GalleryView?
    private let imageManager: ImageManager
    private var pagesCount: Int = 1
    private let imagesPerPage: Int = 30
    
    private var galleryItems: [GalleryItem] = []
    
    // MARK: - Initializers
    
    init(view: GalleryView, imageManager: ImageManager) {
        self.view = view
        self.imageManager = imageManager
    }
    
    // MARK: - GalleryPresenter
    
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
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedGalleryItem = galleryItems[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let galleryItemView = storyboard.instantiateViewController(withIdentifier: "GalleryItemViewController") as? GalleryItemViewController {
            let galleryItemPresenter = GalleryItemPresenterImpl(view: galleryItemView, item: selectedGalleryItem)
            galleryItemView.presenter = galleryItemPresenter
            
            imageManager.fetchImage(url: selectedGalleryItem.fullImageUrl) { image in
                DispatchQueue.main.async {
                    galleryItemPresenter.imageFetched(image)
                }
            } failure: { error in
                
            }
            
            view?.showGalleryItem(galleryItemView)
        }
    }
    
    func viewWillDisappear() {
        DispatchQueue.global(qos: .utility).async {
            self.imageManager.cacheImages(self.galleryItems)
        }
    }
}
