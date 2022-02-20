import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configureCell(image: UIImage?, label: String) {
        self.imageView.image = image
        self.label.text = label
    }
}
