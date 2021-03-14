@testable import thefaelMovie
import XCTest

class FavMoviesCacheTests: XCTestCase {
    let favMovieCache = FavMovieCache.shared
    let userDefaultsAdapterMock = UserDefaultsAdapterMock()

    func test_getFavList_shouldReturnArrayOfPopularMovie() {
        guard let validData = MovieEncoder().movieData else { fatalError("Failed to encode popularMovie on MovieEncoder class") }
        favMovieCache.cache = [String: Data]()
        favMovieCache.cache["key"] = validData
        let favList = [MovieEncoder().popularMovie]
        let sut = favMovieCache.getFavList()

        XCTAssertEqual(sut, favList)
    }

    func test_addMovie_shouldCallSet() {
        let validMovie = MovieEncoder().popularMovie
        favMovieCache.addMovie(validMovie)
        XCTAssert(userDefaultsAdapterMock.didCallSet)
    }
}

class MovieEncoder {
    let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    lazy var movieData = try? JSONEncoder().encode(popularMovie)
}
