import UIKit

class PopularMoviesViewController: UIViewController {
    let interactor: Interactor
    let popularMoviesView = PopularMoviesView(frame: Constants.screen)
    let dataSource = CollectionViewDataSource<PopularMovie, PopularMovieCell>()
    var popularMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.popularMoviesList
                self.popularMoviesView.collectionView.reloadData()
            }
        }
    }

    init(interactor: Interactor = PopularMoviesInteractor()) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = popularMoviesView
        setupCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        fetchPopularMovieList()
    }

    func setupCollectionView() {
        popularMoviesView.createFlowLayout()
        popularMoviesView.setupView()
    }

    func configureCollectionView() {
        popularMoviesView.collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        popularMoviesView.collectionView.dataSource = dataSource
        popularMoviesView.collectionView.delegate = self
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in
            cell.popularMovie = item
        }
    }

    func fetchPopularMovieList() {
        interactor.loadMovieLists { result in
            switch result {
            case .success(let movieList):
                self.popularMoviesList = movieList
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PopularMovieCell, let movie = cell.popularMovie else { return }
        let movieVC = MovieViewController(movie: movie)
//        movieVC.configureVC(with: cell.popularMovie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
