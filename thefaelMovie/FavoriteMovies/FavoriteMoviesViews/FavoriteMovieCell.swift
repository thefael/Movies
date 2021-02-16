import UIKit

class FavoriteMovieCell: UICollectionViewCell {
    var favoriteMovie: PopularMovie? {
        didSet {
            self.loadImage()
        }
    }
    let movieImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.darkBlue
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImageView() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImage)
        movieImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: Constants.screen.width / 3 * CGFloat(Constants.posterAspectRatio)).isActive = true
        movieImage.contentMode = .scaleAspectFit
    }

    private func loadImage() {
        guard let posterPath = favoriteMovie?.posterPath else { return }
        let imageCache = ImageCache.shared
        if let image = imageCache.cache[posterPath] {
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        } else {
            let service = URLSessionService()
            let url = Endpoints.imageURL(from: posterPath)
            service.fetchImage(with: url) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.movieImage.image = image
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
