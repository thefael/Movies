@testable import thefaelMovie
import XCTest

class FavMovieCacheTests: XCTestCase {
    let userDefaultsAdapterMock = UserDefaultsAdapterMock()
    lazy var favMovieCache = FavMovieCache(defaults: userDefaultsAdapterMock)
    let validMovie = MovieEncoder.popularMovie
    let invalidMovie = MovieEncoder.invalidMovie
    let validData = MovieEncoder.movieData
    let invalidData = Data()

    func test_getFavList_whenDataToObjectSucceeds_shouldReturnArrayOfPopularMovie() {
        guard let validData = MovieEncoder.movieData else { fatalError("Failed to encode popularMovie on MovieEncoder class") }
        favMovieCache.cache = [String: Data]()
        favMovieCache.cache["key"] = validData
        let correctFavList = [MovieEncoder.popularMovie]
        let favList = try! favMovieCache.getFavList()

        XCTAssertEqual(favList, correctFavList)
    }

    func test_getFavList_whenDataToObjectFails_shouldThrowCorrectError() {
        favMovieCache.cache = [String: Data]()
        favMovieCache.cache["TestKey"] = invalidData
        XCTAssertThrowsError(try favMovieCache.getFavList()) { error in
            XCTAssertEqual(error as! CommonError, CommonError.failToDecodeData)
        }
    }

    func test_addMovie_whenMovieIsValid_shouldCallSetWithCorrectValue() {
        try! favMovieCache.addMovie(validMovie)
        
        XCTAssert(userDefaultsAdapterMock.didCallSet)
    }

    func test_addMovie_whenMovieIsInvalid_shouldThrowCorrectError() throws {
        XCTAssertThrowsError(try favMovieCache.addMovie(invalidMovie)) { error in
            XCTAssertEqual(error as! CommonError, CommonError.failToEncodeData)
        }
    }

    func test_removeMovie_shouldCallObject() {
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
