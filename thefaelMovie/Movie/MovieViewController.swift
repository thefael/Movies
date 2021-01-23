import UIKit

class MovieViewController: UIViewController {
    var movie: PopularMovie?
    var movieImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

    func configureVC(with movie: PopularMovie?) {
        if let movie = movie {
            self.movie = movie
        }
    }

    func setImageView(image: UIImage?) {
        guard let image = image else { return }
        movieImageView = UIImageView(image: image)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        movieImageView.contentMode = .scaleAspectFit
    }
}
