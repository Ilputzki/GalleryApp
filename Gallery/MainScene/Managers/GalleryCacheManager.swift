import Foundation

final class GalleryCacheManager: CacheManager {
    
    private var galleryItems: [GalleryItem] = []
    private let cacheSize: Int = 120
    
    func getCachedItems() -> [GalleryItem] {
        guard galleryItems.isEmpty else {
            return galleryItems
        }
            
        guard let data = UserDefaults.standard.data(forKey: "GalleryItems") else {
            print("Failed to load gallery items from cache.")
            return []
        }
        
        do {
            galleryItems = try JSONDecoder().decode([GalleryItem].self, from: data)
            return galleryItems
        } catch {
            print("Failed to load gallery items from cache. \(error)")
            return []
        }
    }
    
    func getCachedItems(page: Int, limit: Int) -> [GalleryItem] {
        let galleryItems = self.galleryItems.isEmpty ? getCachedItems() : self.galleryItems
        guard galleryItems.count >= page * limit else { return [] }
        return Array(galleryItems[((page - 1) * limit)..<(page * limit)])
    }
    
    func saveItems(_ items: [GalleryItem]) {
        do {
            galleryItems.append(contentsOf: items)
            let cacheSize = min(self.cacheSize, galleryItems.count)
            let itemsForCaching = Array(items[0..<cacheSize])
            let encoded = try JSONEncoder().encode(itemsForCaching)
            UserDefaults.standard.set(encoded, forKey: "GalleryItems")
        } catch {
            print("Failed to upload gallery items to cache.")
        }
    }
}
