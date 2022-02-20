import UIKit

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, GalleryView {
    
    // MARK: - Properties
    
    private var presenter: GalleryPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appSetUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.viewWillDisappear()
    }
    
    // MARK: - Methods
    
    private func appSetUp() {
        let cacheManager = GalleryCacheManager()
        let imageService = PicsumPhotosService()
        let imageManager = GalleryImageManager(imageService: imageService, cacheManager: cacheManager)
        
        presenter = GalleryPresenterImpl(view: self, imageManager: imageManager)
        presenter?.fetchGalleryItems()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - CollectionView
    
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
        cell.configureCell(image: galleryItem.previewImage, width: galleryItem.width, height: galleryItem.height)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/3.0
        let height = width

        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
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
    
    // MARK: - GalleryView
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showGalleryItem(_ view: GalleryItemViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

