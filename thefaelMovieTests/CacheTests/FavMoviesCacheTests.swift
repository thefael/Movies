@testable import thefaelMovie
import XCTest

class FavMoviesCacheTests: XCTestCase {
    let userDefaultsAdapterMock = UserDefaultsAdapterMock()
    lazy var favMovieCache = FavMovieCache(defaults: userDefaultsAdapterMock)
    let validMovie = MovieEncoder().popularMovie
    let validData = MovieEncoder().movieData

    func test_getFavList_shouldReturnArrayOfPopularMovie() {
        guard let validData = MovieEncoder().movieData else { fatalError("Failed to encode popularMovie on MovieEncoder class") }
        favMovieCache.cache = [String: Data]()
        favMovieCache.cache["key"] = validData
        let correctFavList = [MovieEncoder().popularMovie]
        let favList = favMovieCache.getFavList()

        XCTAssertEqual(favList, correctFavList)
    }

    func test_addMovie_shouldCallSetWithCorrectValue() {
        favMovieCache.addMovie(validMovie)
        
        XCTAssert(userDefaultsAdapterMock.didCallSet)
    }

    func test_removeMovie_shouldSetCorrectCache() {
        favMovieCache.removeMovie(validMovie)

        XCTAssert(userDefaultsAdapterMock.didCallObject)
    }

    func test_IsFavorite_whenMovieIsNotFavorite_ShouldReturnFalse() {
        favMovieCache.cache = [String: Data]()

        let isFavorite = favMovieCache.isFavorite(validMovie)

        XCTAssertFalse(isFavorite)
    }

    func test_IsFavorite_whenMovieIsFavorite_ShouldReturnTrue() {
        favMovieCache.cache = [String: Data]()
        favMovieCache.cache[validMovie.title] = validData

        let isFavorite = favMovieCache.isFavorite(validMovie)

        XCTAssert(isFavorite)
    }
}

class MovieEncoder {
    let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    lazy var movieData = try? JSONEncoder().encode(popularMovie)
}
