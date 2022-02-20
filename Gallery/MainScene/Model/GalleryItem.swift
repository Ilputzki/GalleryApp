import UIKit
class GalleryItem {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let fullImageUrl: String
    var previewImage: UIImage?
    var downloadDate: Date?
    
    init(id: String, author: String, width: Int, height: Int, fullImageUrl: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.fullImageUrl = fullImageUrl
    }
}
