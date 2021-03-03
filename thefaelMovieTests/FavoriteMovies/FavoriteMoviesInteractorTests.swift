import XCTest
@testable import thefaelMovie

class FavoriteMoviesInteractorTests: XCTestCase {
    let posterPath = "posterPath"
    lazy var favoriteMovieFixture = generatePopularMovie(with: posterPath)
    let imageCache = ImageCacheMock.shared
    let service = ServiceMock<UIImage>()
    let favoriteMovieCell = FavoriteMovieCell()
    lazy var favoriteMoviesInteractor = FavoriteMoviesInteractor(service: service, imageCache: imageCache)
    var result: Result<UIImage, Error>?

    override func setUp() {
        imageCache.cache.removeAll()
    }

    func test_loadImage_whenImageCacheHasImage_shouldCallCompletionWithCorrectImage() {
        let image = UIImage()
        imageCache.cache[posterPath] = image
        
        favoriteMoviesInteractor.loadImage(from: favoriteMovieFixture) { r in
            self.result = r
        }

        XCTAssertEqual(try result?.get(), image)
    }

    func test_loadImage_whenServiceFetchImageIsSuccess_shouldCallCompletionWithCorrectImage() {
        favoriteMoviesInteractor.loadImage(from: favoriteMovieFixture) { result in
            self.result = result
        }
        let image = UIImage()
        service.fetchImageArgs?.completion(.success(image))
        XCTAssertEqual(try result?.get(), image)
    }

    func test_loadImage_whenServiceFetchImageIsFailure_shouldCallCompletionWithCorrectError() {
        favoriteMoviesInteractor.loadImage(from: favoriteMovieFixture) { result in
            self.result = result
        }
        service.fetchImageArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try result?.get() }
        catch let e { error = e as? TestError }

        XCTAssertEqual(error, TestError.error)
    }

    private func generatePopularMovie(with posterPath: String) -> PopularMovie {
        let popularMovieFixture = PopularMovie(posterPath: posterPath, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", language: "", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
        return popularMovieFixture
    }
}

enum TestError: Int, Error {
    case error
    case error2
}

