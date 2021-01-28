import UIKit

class MovieViewController: UIViewController {
    let movieView = MovieView(frame: UIScreen.main.bounds)

    override func loadView() {
        view = movieView
        movieView.setupImageView()
        movieView.setupTitle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureView(with movie: PopularMovie?) {
        if let movie = movie {
            movieView.movie = movie
        }
    }
}
