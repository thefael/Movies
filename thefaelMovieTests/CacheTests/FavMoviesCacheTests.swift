@testable import thefaelMovie
import XCTest

class FavMoviesCacheTests: XCTestCase {
    let favMovieCache = FavMovieCache.shared

    func test_getFavList_shouldReturnFavMovieList() {
        guard let validData = MovieEncoder().movieData else { fatalError("Failed to encode popularMovie on MovieEncoder class") }
        favMovieCache.cache.removeAll()
        favMovieCache.cache["key"] = validData
        let favList = [MovieEncoder().popularMovie]
        let sut = favMovieCache.getFavList()

        XCTAssertEqual(sut, favList)
    }
}

class MovieEncoder {
    let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    lazy var movieData = try? JSONEncoder().encode(popularMovie)
}
