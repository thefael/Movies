import UIKit

class PopularMoviesViewController: UIViewController {
    let service: Service
    let popularMoviesView = PopularMoviesView(frame: UIScreen.main.bounds)
    var collectionView: UICollectionView?
    let dataSource = CollectionViewDataSource<PopularMovie, PopularMovieCell>()
    var popularMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.popularMoviesList
                self.collectionView?.reloadData()
            }
        }
    }

    init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = popularMoviesView
        setupCollectionView(layout: popularMoviesView.createFlowLayout())
        popularMoviesView.setupView(collectionView: collectionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        fetchPopularMoviesList()
        collectionView?.delegate = self
    }

    func setupCollectionView(layout: UICollectionViewFlowLayout) {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(PopularMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView?.backgroundColor = Constants.darkBlue
        collectionView?.dataSource = dataSource
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in
            cell.popularMovie = item
        }
    }

    func fetchPopularMoviesList() {
        service.fetchData(with: Endpoints.popularMoviesListURL()) { (result: Result<PopularMovies, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieList):
                self.popularMoviesList = movieList.movies
            }
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecionou aqui \(indexPath.row)")
        let movieVC = MovieViewController()
        guard let cell = collectionView.cellForItem(at: indexPath) as? PopularMovieCell else { return }
        movieVC.configureVC(with: cell.popularMovie)
        movieVC.setImageView(image: cell.imageView.image)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
