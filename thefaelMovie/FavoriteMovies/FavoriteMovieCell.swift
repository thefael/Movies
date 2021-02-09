import UIKit

class FavoriteMovieCell: UICollectionViewCell {
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
        movieImage.contentMode = .scaleAspectFit
    }
}
