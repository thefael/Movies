import UIKit

class FavoriteMoviesViewController: UIViewController {
    let favoriteMoviesView = FavoriteMoviesView(frame: Constants.screen)
    let dataSource = CollectionViewDataSource<PopularMovie, FavoriteMovieCell>()
    var favoriteMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.favoriteMoviesList
            }
        }
    }

    override func loadView() {
        view = favoriteMoviesView
        setupCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        configureCollectionView()
    }

    func setupCollectionView() {
        favoriteMoviesView.createFlowLayout()
        favoriteMoviesView.setupView()
    }

    func configureCollectionView() {
        favoriteMoviesView.collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        favoriteMoviesView.collectionView.dataSource = dataSource
        favoriteMoviesView.collectionView.reloadData()
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in
            cell.favoriteMovie = item
        }
    }
}
