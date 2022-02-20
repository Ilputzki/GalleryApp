protocol CacheManager {
    
    func getCachedItems() -> [GalleryItem]
    
    func getCachedItems(page: Int, limit: Int) -> [GalleryItem]
    
    func saveItems(_ items: [GalleryItem])
}
