@testable import thefaelMovie
import UIKit

class MovieEncoder {
    static let popularMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: 0.0)
    static let invalidMovie = PopularMovie(posterPath: nil, adult: true, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "title", language: "", backdropPath: nil, popularity: 0.0, voteCount: 0, video: true, voteAverage: Double.infinity)
    static var movieData = try? JSONEncoder().encode(popularMovie)
}
