import UIKit

class PopularMovieCell: UICollectionViewCell {
    let service = Service()
    var image = UIImageView()
    var imageCache: [Int: UIImage]?
    var popularMovie: PopularMovie? {
        didSet {
            if let popularMovie = self.popularMovie {
                guard let posterPathString = popularMovie.posterPath else { return }
                let posterPath = Endpoints.imageURL(from: posterPathString)
                self.fetchImage(with: posterPath)
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
                self.image.image = UIImage()
            case .success(let image):
                DispatchQueue.main.async {
                    self.image.image = image
                }
            }
        }
    }

    private func configureSubviews() {
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        image.clipsToBounds = true
    }

    private func setImageConstraints() {
        contentView.addSubview(image)
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1).isActive = true
        image.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        image.contentMode = .scaleAspectFill
    }
}
