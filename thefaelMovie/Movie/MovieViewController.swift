import UIKit

class MovieViewController: UIViewController {
    let movie: PopularMovie
    lazy var movieView = MovieView(frame: Constants.screen, movie: movie)

    init(movie: PopularMovie) {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
