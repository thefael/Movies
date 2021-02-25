import XCTest
@testable import thefaelMovie

class FavoriteMoviesInteractorTests: XCTestCase {
    let imageCache = ImageCacheMock.shared
    let service = ServiceMock<UIImage>()
    let favoriteMovieCell = FavoriteMovieCell()
    lazy var favoriteMoviesInteractor = FavoriteMoviesInteractor(service: service, imageCache: imageCache)
    var result: Result<[PopularMovie], Error>?

    func test_loadImage_whenImageCacheHasImage_shouldSetCellImageWithCorrectImage() {
        let posterPath = "posterPath"
        let popularMovieFixture = generatePopularMovie(with: posterPath)
        let image = UIImage()
        imageCache.cache[posterPath] = image

        favoriteMoviesInteractor.loadImage(from: popularMovieFixture, into: favoriteMovieCell)

        XCTAssertEqual(favoriteMovieCell.movieImage.image, image)
    }

    private func generatePopularMovie(with posterPath: String) -> PopularMovie {
        let popularMovieFixture = PopularMovie(posterPath: posterPath, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", language: "", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
        return popularMovieFixture
    }
}

