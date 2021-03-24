@testable import thefaelMovie
import UIKit

class MovieGenerator {
    static let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    static let invalidMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: Double.infinity)
    static let movieWithPath = PopularMovie(posterPath: "testPath", adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    static var movieData = try? JSONEncoder().encode(popularMovie)
}
