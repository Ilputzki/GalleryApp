import UIKit

class GalleryItem: Codable {
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
        self.author = try container.decode(String.self, forKey: CodingKeys.author)
        self.width = try container.decode(Int.self, forKey: CodingKeys.width)
        self.height = try container.decode(Int.self, forKey: CodingKeys.height)
        self.fullImageUrl = try container.decode(String.self, forKey: CodingKeys.fullImageUrl)
        self.downloadDate = try container.decode(Date.self, forKey: CodingKeys.downloadDate)
        
        let data = try container.decode(Data.self, forKey: CodingKeys.previewImage)
        guard let image = UIImage(data: data) else {
          throw NSError(domain: "", code: 0, userInfo: nil)
        }
        self.previewImage = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(author, forKey: CodingKeys.author)
        try container.encode(width, forKey: CodingKeys.width)
        try container.encode(height, forKey: CodingKeys.height)
        try container.encode(fullImageUrl, forKey: CodingKeys.fullImageUrl)
        try container.encode(downloadDate, forKey: CodingKeys.downloadDate)
        
        let data = fullImageUrl.data(using: .utf8)
        try container.encode(data, forKey: CodingKeys.previewImage)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case fullImageUrl
        case previewImage
        case downloadDate
    }
}
