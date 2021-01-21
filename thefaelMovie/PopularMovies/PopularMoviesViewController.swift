import UIKit

class PopularMoviesViewController: UIViewController {
    let service = Service()
    var collectionView: UICollectionView?
    let dataSource = CollectionViewDataSource<PopularMovie, PopularMovieCell>()
    var popularMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.list = self.popularMoviesList
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        configureCell()
        fetchPopularMoviesList()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screen = UIScreen.main.bounds
        let width = screen.width/2.5
        let height = width / CGFloat(Constants.posterAspectRatio)
        layout.sectionInset = UIEdgeInsets(top: 5, left: width/5, bottom: 0, right: width/5)

        layout.itemSize = CGSize(width: width, height: height)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(PopularMovieCell.self, forCellWithReuseIdentifier: "ReusableCell")
        collectionView?.backgroundColor = UIColor(red: 0.1, green: 0.15, blue: 0.3, alpha: 1.0)
        collectionView?.dataSource = dataSource
        view.addSubview(collectionView ?? UICollectionView())
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
