import UIKit

protocol ImageService {
    
    func fetchImagesList(page: Int, limit: Int,
                         success: @escaping ([GalleryItem]) -> Void,
                         failure: @escaping (Error) -> Void)
    
    func fetchImage(url: String,
                    success: @escaping (UIImage) -> Void,
                    failure: @escaping (Error) -> Void)
    
    func fetchImage(id: String, width: Int, height: Int,
                    success: @escaping (UIImage) -> Void,
                    failure: @escaping (Error) -> Void) 
}
