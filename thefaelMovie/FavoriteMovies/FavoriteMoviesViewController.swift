import UIKit

class FavoriteMoviesViewController: UIViewController {
    let favoriteMoviesView = FavoriteMoviesView(frame: Constants.screen)
    let favMovieCache = FavMovieCache.shared
    let dataSource = CollectionViewDataSource<PopularMovie, FavoriteMovieCell>()
    let interactor = FavoriteMoviesInteractor()

    override func loadView() {
        view = favoriteMoviesView
        setupCollectionView()
        configureCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.dataSource.items = self.favMovieCache.getFavList()
            self.favoriteMoviesView.collectionView.reloadData()
        }
    }

    func setupCollectionView() {
        favoriteMoviesView.createFlowLayout()
        favoriteMoviesView.setupView()
    }

    func configureCollectionView() {
        favoriteMoviesView.collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        favoriteMoviesView.collectionView.dataSource = dataSource
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in
            cell.favoriteMovie = item
            cell.loadImage = {
                self.interactor.loadImage(from: item) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.movieImage.image = image
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
