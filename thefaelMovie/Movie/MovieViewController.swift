import UIKit

class MovieViewController: UIViewController {
    var movie: PopularMovie?
    var movieImageView = UIImageView()
    var movieTitle = UILabel()
    let screen = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.darkBlue
    }

    func configureVC(with movie: PopularMovie?) {
        if let movie = movie {
            self.movie = movie
        }
    }

    func setImageView(image: UIImage?) {
        guard let image = image else { return }
        movieImageView = UIImageView(image: image)
        movieImageView.backgroundColor = .red
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: screen.width/CGFloat(Constants.posterAspectRatio)).isActive = true
        movieImageView.contentMode = .scaleAspectFit
        setTitle()
    }

    func setTitle() {
        guard let movie = movie else { return }
        movieTitle.text = movie.title
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieTitle)
        movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        movieTitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
