import UIKit

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, GalleryView {
    
    private var presenter: GalleryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appSetUp()
    }
    
    private func appSetUp() {
        // Возможно часть перенести в AppDelegate
        let cacheManager = GalleryCacheManager()
        let imageService = PicsumPhotosService()
        let imageManager = GalleryImageManager(imageService: imageService, cacheManager: cacheManager)
        
        presenter = GalleryPresenterImpl(view: self, imageManager: imageManager)
        presenter?.fetchGalleryItems()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getRows(at: section) ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell,
            let galleryItem = presenter?.getGalleryItem(for: indexPath)
        else {
            return GalleryCell()
        }
        cell.configureCell(image: galleryItem.previewImage, label: galleryItem.author)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/3.0
        let height = width

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row >= collectionView.numberOfItems(inSection: 0) - 3) {
            presenter?.scrolledToBottom()
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

