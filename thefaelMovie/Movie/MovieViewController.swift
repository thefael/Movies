import UIKit

class MovieViewController: UIViewController {
    let movie: PopularMovie
    lazy var movieView = MovieView(frame: Constants.screen, movie: movie)

    init(movie: PopularMovie) {
//        self.init(nibName: nil, bundle: nil)
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        movieView.setupView()
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = movieView
//        movieView.setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        movieView.setupView()
    }

//    func configureVC(with movie: PopularMovie?) {
//        if let movie = movie {
//            movieView.movie = movie
//        }
//        hidesBottomBarWhenPushed = true
//    }
}
