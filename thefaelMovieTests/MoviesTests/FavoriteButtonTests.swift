@testable import thefaelMovie
import XCTest

class FavoriteButtonTests: XCTestCase {
    let movie = MovieEncoder.popularMovie
    let validData = MovieEncoder.movieData

    func test_buttonTapped_whenMovieIsFavorite_shouldCallRemoveMovie() {
        let cache = [String: Data]()
        let favMovieCacheMock = FavMovieCacheMock(cache: cache)
        favMovieCacheMock.movieIsFavorite = true
        let favoriteButton = FavoriteButton(cache: favMovieCacheMock)
        favoriteButton.movie = movie

        favoriteButton.buttonTapped()
        XCTAssert(favMovieCacheMock.didCallRemoveMovie)
    }

    func test_buttonTapped_whenMovieIsNotFavorite_shouldCallAddMovie_andSucceed() {
        let cache = [String: Data]()
        let favMovieCacheMock = FavMovieCacheMock(cache: cache)
        favMovieCacheMock.movieIsFavorite = false
        let favoriteButton = FavoriteButton(cache: favMovieCacheMock)
        favoriteButton.movie = movie

        favoriteButton.buttonTapped()
        XCTAssert(favMovieCacheMock.didCallAddMovie)
    }

    func test_buttonTapped_whenMovieIsNotFavorite_andNotValid_shouldCallAddMovie_andFail() {
        let cache = [String: Data]()
        let favMovieCacheMock = FavMovieCacheMock(cache: cache)
        favMovieCacheMock.movieIsFavorite = false
        favMovieCacheMock.movieIsValid = false
        let favoriteButton = FavoriteButton(cache: favMovieCacheMock)
        favoriteButton.movie = movie

        XCTAssertThrowsError(favoriteButton.buttonTapped()) { error in
            XCTAssertEqual(error as! TestError, TestError.error)
        }
    }
}

