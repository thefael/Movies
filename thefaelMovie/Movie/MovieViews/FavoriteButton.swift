import UIKit

class FavoriteButton: UIButton {
    private let favCache = FavMovieCache.shared
    var movie: PopularMovie? {
        didSet {
            self.setButtonImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonTapped() {
        print("entra aqui")
        guard let movie = movie else { return }

        let heart = UIImage(systemName: "heart")
        let heartFill = UIImage(systemName: "heart.fill")
        if favCache.isFavorite(movie) {
            favCache.removeMovie(movie)
            setImage(heart, for: .normal)
        } else {
            do { try favCache.addMovie(movie) }
            catch { print(error) }
            setImage(heartFill, for: .normal)
        }
    }

    func setButtonImage() {
        guard let movie = movie else { return }
        let heart = UIImage(systemName: "heart")
        let heartFill = UIImage(systemName: "heart.fill")
        if favCache.isFavorite(movie) {
            setImage(heartFill, for: .normal)
        } else {
            setImage(heart, for: .normal)
        }
    }

    func setMovieForButton(movie: PopularMovie) {
        self.movie = movie
    }
    
}
