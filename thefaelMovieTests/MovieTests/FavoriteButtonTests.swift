@testable import thefaelMovie
import FBSnapshotTestCase

class FavoriteButtonTests: FBSnapshotTestCase {
    let cache = FavMovieCacheMock(cache: [String : Data]())
    lazy var favoriteButton = FavoriteButton(cache: cache, frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    override func setUp() {
        super.setUp()
        self.recordMode = false
        favoriteButton.movie = MovieGenerator.popularMovie
    }

    func test_buttonTapped_whenMovieIsFavorite_buttonShouldLookLikeThis() {
        cache.movieIsFavorite = true
        
        favoriteButton.buttonTapped()
        
        FBSnapshotVerifyView(favoriteButton)
    }

    func test_buttonTapped_whenMovieIsNotFavorite_buttonShouldLookLikeThis() {
        cache.movieIsFavorite = false

        favoriteButton.buttonTapped()

        FBSnapshotVerifyView(favoriteButton)
    }

    func test_setButtonImage_whenMovieIsFavorite_buttonShouldLookLikeThis() {
        cache.movieIsFavorite = true

        favoriteButton.setButtonImage()

        FBSnapshotVerifyView(favoriteButton)
    }

    func test_setButtonImage_whenMovieIsNotFavorite_buttonShouldLookLikeThis() {
        cache.movieIsFavorite = false

        favoriteButton.setButtonImage()

        FBSnapshotVerifyView(favoriteButton)
    }
}

