import UIKit

class PopularMovieCell: UICollectionViewCell {
    let service = URLSessionService()
    var imageView = UIImageView()
    var imageCache: [Int: UIImage]?
    var popularMovie: PopularMovie? {
        didSet {
            if let popularMovie = self.popularMovie {
                guard let posterPathString = popularMovie.posterPath else { return }
                self.fetchImage(with: posterPathString)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        configureSubviews()
        setImageConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func fetchImage(with string: String) {
        let url = Endpoints.imageURL(from: string)
        service.fetchImage(with: url) { result in
            switch result {
            case .failure(_):
                self.imageView.image = UIImage()
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    private func configureSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.clipsToBounds = true
    }

    private func setImageConstraints() {
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
    }
}
