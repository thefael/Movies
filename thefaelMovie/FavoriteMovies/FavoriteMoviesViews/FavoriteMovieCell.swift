import UIKit

class FavoriteMovieCell: UICollectionViewCell {
    var favoriteMovie: PopularMovie?
    var loadImage: (() -> Void)? {
        didSet {
            self.loadImage?()
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
}
