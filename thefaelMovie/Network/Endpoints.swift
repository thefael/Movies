import Foundation

enum Endpoints {
    private static var baseComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        return components
    }()

    static func popularMoviesListURL(page: Int = 1) -> URL {
        let queryItems = [
            URLQueryItem(name: "api_key", value: Constants.APIKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        var components = baseComponents
        components.path = "/3/movie/popular"
        components.queryItems = queryItems

        guard let url = components.url else {
            fatalError("Wrong URL.")
        }
        return url
    }

    static func imageURL(from path: String = "8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg") -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p/w500/\(path)"

        guard let url = components.url else {
            fatalError("Wrong ImageURL.")
        }
        return url
    }
}
