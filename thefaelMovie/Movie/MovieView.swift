import UIKit
import Cosmos
import TinyConstraints

class MovieView: UIView {
    private let movieImageView = UIImageView()
    private let movieTitle = UILabel()
    private let imageCache = ImageCache.shared
    var movie: PopularMovie? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.darkBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImageView() {
        guard let path = movie?.posterPath else { return }
        guard let image = imageCache.cache[path] else { return }
        movieImageView.image = image
        movieImageView.backgroundColor = .red
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/CGFloat(Constants.posterAspectRatio)).isActive = true
        movieImageView.contentMode = .scaleAspectFit
    }

    func setupTitle() {
        guard let movie = movie else { return }
        movieTitle.text = movie.title
        movieTitle.textAlignment = .center
        movieTitle.textColor = Colors.yellow
        movieTitle.backgroundColor = Colors.darkestBlue
        movieTitle.font = UIFont(name: "Avenir-Heavy", size: 18)

        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieTitle)
        movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        movieTitle.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        movieTitle.lineBreakMode = .byWordWrapping
        movieTitle.numberOfLines = 2
    }

    func setupRatingView() {
        let cosmosView: CosmosView = {
            let view = CosmosView()
            return view
        }()
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cosmosView)
        cosmosView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor).isActive = true
        cosmosView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
    }
}
