import UIKit

class MovieViewController: UIViewController {
    let movieView = MovieView(frame: Constants.screen)

    override func loadView() {
        view = movieView
        movieView.setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureVC(with movie: PopularMovie?) {
        if let movie = movie {
            movieView.movie = movie
        }
        hidesBottomBarWhenPushed = true
    }
}
