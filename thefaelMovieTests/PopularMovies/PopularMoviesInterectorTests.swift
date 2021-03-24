import XCTest
@testable import thefaelMovie

class PopularMoviesInteractorTests: XCTestCase {
    let service = ServiceMock<PopularMovies>()
    lazy var popularMoviesInteractor = PopularMoviesInteractor(service: service)
    var result: (Result<[PopularMovie], Error>)?

    func test_loadMovieList_whenServiceFetchDataIsSuccess_ShouldCallCompletionWithCorrectList() {
        popularMoviesInteractor.loadMovieList { result in
            self.result = result
        }
        let popularMoviesFixture = generatePopularMovies()
        service.fetchDataArgs?.completion(.success(popularMoviesFixture))

        XCTAssertEqual(try result?.get(), popularMoviesFixture.movies)
    }

    func test_loadMovieList_whenServiceFetchDataIsFailure_ShouldCallCompletionWithCorrectError() {
        popularMoviesInteractor.loadMovieList { result in
            self.result = result
        }
        service.fetchDataArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try result?.get() }
        catch let e { error = e as? TestError}

        XCTAssertEqual(error, TestError.error)
    }

    private func generatePopularMovies() -> PopularMovies {
        let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: false, voteAverage: 0.0)
        let popularMoviesFixture = PopularMovies(page: 0, movies: [popularMovie], totalResults: 0, totalPages: 0)
        return popularMoviesFixture
    }
}
