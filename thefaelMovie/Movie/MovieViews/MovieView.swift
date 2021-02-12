import UIKit
import Cosmos
import TinyConstraints

class MovieView: UIView {
    private let movieImageView = UIImageView()
    private let movieTitle = UILabel()
    private let cosmosView = CosmosView()
    private let numOfRatings = UILabel()
    private let favButton = FavoriteButton()
    private let imageCache = ImageCache.shared
    private let scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView()
    private let movie: PopularMovie

    init(frame: CGRect, movie: PopularMovie) {
        self.movie = movie
        super.init(frame: frame)
        backgroundColor = Color.darkBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupScrollView()
        setupImageView()
        setupTitle()
        setupRatingView()
        setupNumOfRatings()
        setupFavButton()
    }

    func setupScrollView() {
        containerView.frame.size = UIScreen.main.bounds.size
        scrollView.frame = UIScreen.main.bounds
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        scrollView.contentSize.width = Constants.screen.width
    }

    func setupImageView() {
        guard let path = movie.posterPath else { return }
        guard let image = imageCache.cache[path] else { return }
        movieImageView.image = image
        movieImageView.backgroundColor = .red

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/CGFloat(Constants.posterAspectRatio)).isActive = true
        movieImageView.contentMode = .scaleAspectFit
    }

    func setupTitle() {
        movieTitle.text = movie.title
        movieTitle.textAlignment = .center
        movieTitle.textColor = Color.yellow
        movieTitle.backgroundColor = Color.darkestBlue
        movieTitle.font = UIFont(name: "Avenir-Heavy", size: 18)

        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(movieTitle)
        movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        movieTitle.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        movieTitle.lineBreakMode = .byWordWrapping
        movieTitle.numberOfLines = 2
    }

    func setupRatingView() {
        cosmosView.settings.fillMode = .precise
        let rating = movie.voteAverage
        cosmosView.rating = rating/2
        cosmosView.text = String(rating/2).replacingOccurrences(of: ".", with: ",")

        cosmosView.settings.textFont = UIFont(name: "Avenir-Heavy", size: 22) ?? UIFont()
        cosmosView.settings.textMargin = 10
        cosmosView.settings.textColor = Color.yellow
        cosmosView.settings.filledColor = Color.yellow
        cosmosView.settings.updateOnTouch = false

        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cosmosView)
        cosmosView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        cosmosView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
    }

    func setupNumOfRatings() {
        let ratings = movie.voteCount
        if ratings >= 1000 {
            numOfRatings.text = "\(String(format: "%.1f", Float(ratings)/1000))k Ratings"
        } else {
            numOfRatings.text = "\(String(ratings)) Ratings"
        }
        numOfRatings.textColor = Color.gray
        numOfRatings.font = UIFont(name: "Avenir-Heavy", size: 11)

        numOfRatings.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(numOfRatings)
        numOfRatings.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: 3).isActive = true
        numOfRatings.centerXAnchor.constraint(equalTo: cosmosView.centerXAnchor).isActive = true
    }

    func setupFavButton() {
        favButton.setMovieForButton(movie: movie)
        favButton.addTarget(self, action: #selector (buttonTapped), for: .touchUpInside)
        favButton.tintColor = Color.gray
        favButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(favButton)
        favButton.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        favButton.leftAnchor.constraint(equalTo: cosmosView.rightAnchor, constant: 15).isActive = true
    }

    @objc func buttonTapped() {
        favButton.buttonTapped()
    }
}
