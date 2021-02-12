import UIKit

class FavoriteButton: UIButton {
    private let favCache = FavMovieCache.shared
    let defaults = UserDefaults.standard
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
        if isFavorite(movie) {
            defaults.removeObject(forKey: movie.title)
            setImage(heart, for: .normal)
        } else {
            defaults.setObject(movie, forKey: movie.title)
            setImage(heartFill, for: .normal)
        }
    }

    func isFavorite(_ movie: PopularMovie) -> Bool {
        if let _ = defaults.object(forKey: movie.title) {
            return true
        } else {
            return false
        }
    }

    func setButtonImage() {
        guard let movie = movie else { return }
        let heart = UIImage(systemName: "heart")
        let heartFill = UIImage(systemName: "heart.fill")
        if isFavorite(movie) {
            setImage(heartFill, for: .normal)
        } else {
            setImage(heart, for: .normal)
        }
    }

    func setMovieForButton(movie: PopularMovie) {
        self.movie = movie
    }
    
}
