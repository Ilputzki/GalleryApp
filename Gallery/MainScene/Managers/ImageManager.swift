import UIKit

protocol ImageManager {
    
    var imageService: ImageService { get }
    
    var cacheManager: CacheManager { get }
    
    func fetchImages(page: Int, limit: Int,
                     galleryItemListFetched: @escaping ([GalleryItem]) -> Void,
                     galleryItemImageFetched: @escaping (GalleryItem, UIImage) -> Void,
                     failure: @escaping (Error) -> Void)
    
    func fetchImage(url: String,
                    success: @escaping (UIImage) -> Void,
                    failure: @escaping (Error) -> Void)
    
    func cacheImages(_ items: [GalleryItem])
}
