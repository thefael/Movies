import UIKit

class FavoriteMoviesViewController: UIViewController {
    let favoriteMoviesView = FavoriteMoviesView(frame: Constants.screen)
    let dataSource = CollectionViewDataSource<PopularMovie, UICollectionViewCell>()
    var favoriteMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.favoriteMoviesList
            }
        }
    }

    override func loadView() {
        view = favoriteMoviesView
        favoriteMoviesView.createFlowLayout()
        favoriteMoviesView.setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMoviesView.collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        favoriteMoviesView.collectionView.dataSource = dataSource
        favoriteMoviesView.collectionView.reloadData()
    }
}
