import UIKit

class PopularMoviesViewController: UIViewController {
    let service = Service()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        configureCell()
        fetchPopularMoviesList()
        collectionView?.delegate = self
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screen = UIScreen.main.bounds
        let width = screen.width/2
        let height = width / CGFloat(Constants.posterAspectRatio)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(PopularMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
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
