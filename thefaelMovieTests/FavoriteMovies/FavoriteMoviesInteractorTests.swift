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

    func test_loadImage_whenImageCacheHasImage_shouldCallCompletionWithCorrectImage() {
        let image = UIImage()
        imageCache.cache[posterPath] = image
        
        favoriteMoviesInteractor.loadImage(from: favoriteMovieFixture) { r in
            self.result = r
        }

        XCTAssertEqual(try result?.get(), image)
    }

    private func generatePopularMovie(with posterPath: String) -> PopularMovie {
        let popularMovieFixture = PopularMovie(posterPath: posterPath, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", language: "", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
        return popularMovieFixture
    }
}

enum TestError: Int, Error {
    case error
}

