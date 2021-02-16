import UIKit

class FavoriteMoviesView: UIView {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createFlowLayout() {
        let width = Constants.screen.width
        let height = width / 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }

    func setupView() {
        collectionView = UICollectionView(frame: Constants.screen, collectionViewLayout: layout)
        collectionView.backgroundColor = Color.darkBlue
        addSubview(collectionView)
    }
}
