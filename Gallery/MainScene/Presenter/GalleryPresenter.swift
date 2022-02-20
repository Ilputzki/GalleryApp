import Foundation

protocol GalleryPresenter {
    
    var view: GalleryView? { get set }
    
    func getRows(at section: Int) -> Int
    
    func getGalleryItem(for indexPath: IndexPath) -> GalleryItem
    
    func fetchGalleryItems()
    
    func scrolledToBottom()
    
    func didSelectItem(at indexPath: IndexPath)
}
