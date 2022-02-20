import Foundation
import UIKit

final class PicsumPhotosService: ImageService {
    
    // MARK: - Properties
    
    private let url = "https://picsum.photos"
    private let configuration: URLSessionConfiguration = .default
    private lazy var urlSession: URLSession = .init(configuration: configuration)
    
    // MARK: - Methods
    
    func fetchImagesList(page: Int, limit: Int,
                         success: @escaping ([GalleryItem]) -> Void,
                         failure: @escaping (Error) -> Void) {
        guard let requestUrl: URL = .init(string: "\(url)/v2/list?page=\(page)&limit=\(limit)") else {
            // Доделать
            failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let request: URLRequest = .init(url: requestUrl)
        let dataTask = urlSession.dataTask(with: request) { data, response, error  in
            do {
                guard error == nil else {
                    // Доделать
                    failure(NSError(domain: "", code: 0, userInfo: nil))
                    return
                }
                let requestStatusCode = (response as? HTTPURLResponse)?.statusCode
                guard requestStatusCode == 200 else {
                    // Доделать
                    failure(NSError(domain: "", code: 0, userInfo: nil))
                    return
                }
                let items = try JSONDecoder().decode([PicsumPhotosItem].self, from: data!)
                let galleryItems = self.createGalleryItems(from: items)
                success(galleryItems)
            }
            catch {
                // Доделать
                failure(NSError(domain: "", code: 0, userInfo: nil))
            }
        }
        dataTask.resume()
    }
    
    func fetchImage(url: String,
                    success: @escaping (UIImage) -> Void,
                    failure: @escaping (Error) -> Void) {
        guard let requestUrl: URL = .init(string: url) else {
            // Доделать
            failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let request: URLRequest = .init(url: requestUrl)
        let dataTask = urlSession.dataTask(with: request) { data, response, error  in
            guard error == nil else {
                // Доделать
                failure(NSError(domain: "", code: 0, userInfo: nil))
                return
            }
            let requestStatusCode = (response as? HTTPURLResponse)?.statusCode
            guard requestStatusCode == 200,
            let data = data else {
                // Доделать
                failure(NSError(domain: "", code: 0, userInfo: nil))
                return
            }
            guard let requestedImage: UIImage = .init(data: data) else {
                // Доделать
                failure(NSError(domain: "", code: 0, userInfo: nil))
                return
            }
            success(requestedImage)
        }
        dataTask.resume()
    }
    
    func fetchImage(id: String, width: Int, height: Int,
                    success: @escaping (UIImage) -> Void,
                    failure: @escaping (Error) -> Void) {
        let requestUrl = "\(url)/id/\(id)/\(width)/\(height)"
        fetchImage(url: requestUrl, success: success, failure: failure)
    }
    
    private func createGalleryItems(from items: [PicsumPhotosItem]) -> [GalleryItem] {
        var galleryItems: [GalleryItem] = []
        for item in items {
            let galleryItem = GalleryItem(id: item.id, author: item.author, width: item.width, height: item.height, fullImageUrl: item.downloadUrl)
            galleryItems.append(galleryItem)
        }
        
        return galleryItems
    }
}
