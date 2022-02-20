import UIKit

protocol GalleryItemView: AnyObject {
    
    func setImage(_ image: UIImage?)
    
    func setNavigationItemTitle(_ title: String?)
}
