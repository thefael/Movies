import UIKit

class PopularMovieCell: UICollectionViewCell {
    let service = URLSessionService()
    var imageView = UIImageView()
    var imageCache = ImageCache.shared
    var popularMovie: PopularMovie? {
        didSet {
            if let popularMovie = self.popularMovie {
                guard let posterPathString = popularMovie.posterPath else { return }
                self.fetchImage(from: posterPathString)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func fetchImage(from path: String) {
        if let image = imageCache.cache[path] {
            imageView.image = image
        } else {
            let url = Endpoints.imageURL(from: path)
            service.fetchImage(with: url) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.imageCache.cache[path] = image
                    }
                }
            }
        }
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
    }
}
