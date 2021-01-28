import UIKit

class PopularMoviesViewController: UIViewController {
    let interactor: Interactor
    let popularMoviesView = PopularMoviesView(frame: UIScreen.main.bounds)
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let dataSource = CollectionViewDataSource<PopularMovie, PopularMovieCell>()
    var popularMoviesList = [PopularMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.popularMoviesList
                self.collectionView.reloadData()
            }
        }
    }

    init(interactor: Interactor) {
        self.interactor = interactor
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
        fetchPopularMovieList()
        collectionView.delegate = self
    }

    func setupCollectionView(layout: UICollectionViewFlowLayout) {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.dataSource = dataSource
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in
            cell.popularMovie = item
        }
    }

    func fetchPopularMovieList() {
        interactor.loadMovieList(onSuccess: { popularMoviesList in
            self.popularMoviesList = popularMoviesList
        }, onError: { error in
            print(error)
        })
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecionou aqui \(indexPath.row)")
        let movieVC = MovieViewController()
        guard let cell = collectionView.cellForItem(at: indexPath) as? PopularMovieCell else { return }
        movieVC.configureView(with: cell.popularMovie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
