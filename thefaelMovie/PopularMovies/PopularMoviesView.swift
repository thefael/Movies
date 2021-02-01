import UIKit

class PopularMoviesView: UIView {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("Required init gone wrong.")
    }

    func createFlowLayout() {
        let width = UIScreen.main.bounds.width/2
        let height = width / CGFloat(Constants.posterAspectRatio)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }

    func setupView() {
        backgroundColor = .white
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.darkBlue
        addSubview(collectionView)
    }
}
