import UIKit

final class GalleryImageManager: ImageManager {
    
    let imageService: ImageService
    let cacheManager: CacheManager
    private let previewMinSide: Float = 400
    
    init(imageService: ImageService, cacheManager: CacheManager) {
        self.imageService = imageService
        self.cacheManager = cacheManager
    }
    
    func fetchImages(page: Int, limit: Int,
                     galleryItemListFetched: @escaping ([GalleryItem]) -> Void,
                     galleryItemImageFetched: @escaping (GalleryItem, UIImage) -> Void,
                     failure: @escaping (Error) -> Void) {
        imageService.fetchImagesList(page: page, limit: limit) { items in
            for item in items {
                let k: Float = Float(min(item.width, item.height)) / self.previewMinSide
                let previewWidth = Int(Float(item.width) / k)
                let previewHeight = Int(Float(item.height) / k)
                
                self.imageService.fetchImage(id: item.id, width: previewWidth, height: previewHeight) { image in
                    galleryItemImageFetched(item, image)
                } failure: { error in
                    failure(error)
                }
            }
            galleryItemListFetched(items)
        } failure: { error in
            failure(error)
        }
        
    }

}
