import UIKit

class PopularMovieCell: UICollectionViewCell {
    let service = Service()
    var image = UIImageView()
    var imageURL: URL? {
        didSet {
            if let imageURL = self.imageURL {
                self.fetchImage(with: imageURL)
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

    private func fetchImage(with url: URL) {
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
