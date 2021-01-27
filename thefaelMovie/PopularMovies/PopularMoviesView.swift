import UIKit

class PopularMoviesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("Required init gone wrong.")
    }

    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let screen = UIScreen.main.bounds
        let width = screen.width/2
        let height = width / CGFloat(Constants.posterAspectRatio)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }

    func setupView(collectionView: UICollectionView?) {
        backgroundColor = .white
        addSubview(collectionView ?? UICollectionView())
    }
}
