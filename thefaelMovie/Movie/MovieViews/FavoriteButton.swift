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
        if isFavorite(movie) {
            guard let index = favCache.cache.firstIndex(where: { $0.title == movie.title }) else { return }
            favCache.cache.remove(at: index)
            setImage(heart, for: .normal)
        } else {
            favCache.cache.append(movie)
            setImage(heartFill, for: .normal)
        }
    }

    func isFavorite(_ movie: PopularMovie) -> Bool {
        if favCache.cache.contains(where: { $0.title == movie.title }) {
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
