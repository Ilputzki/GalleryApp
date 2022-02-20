protocol GalleryView: AnyObject {
    
    func reloadData()
    
    func showGalleryItem(_ view: GalleryItemViewController)
}
