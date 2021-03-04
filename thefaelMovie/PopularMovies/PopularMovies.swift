import Foundation

struct PopularMovies: Codable {
    let page: Int
    let movies: [PopularMovie]
    let totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct PopularMovie: Codable, Equatable {
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIDs: [Int]
    let id: Int
    let title: String
    let language: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case id = "id"
        case title = "original_title"
        case language = "original_language"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
    }
}
