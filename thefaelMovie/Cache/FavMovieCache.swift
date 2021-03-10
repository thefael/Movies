import UIKit

class FavMovieCache {
    static var shared = FavMovieCache()
    private let defaults = UserDefaults.standard
    private var favMoviesData = [String: Data]()

    private init() {
        if let obj = defaults.object(forKey: "favoriteMoviesList") as? Dictionary<String, Data> {
            favMoviesData = obj
            for dict in favMoviesData {
                print(dataToMovie(data: dict.value).title)
            }
        }
    }

    func getFavList() -> [PopularMovie] {
        var favMovieList = [PopularMovie]()
        for dict in favMoviesData {
            let movie = dataToMovie(data: dict.value)
            favMovieList.append(movie)
        }
        return favMovieList
    }

    func getMovie(with title: String?) -> PopularMovie? {
        var favMovieList = [PopularMovie]()
        for dict in favMoviesData {
            let movie = dataToMovie(data: dict.value)
            favMovieList.append(movie)
        }
        let movie = favMovieList.first(where: { $0.title == title })
        return movie
    }

    func addMovie(_ movie: PopularMovie) {
        let data = movieToData(movie: movie)
        favMoviesData[movie.title] = data
        defaults.set(favMoviesData, forKey: "favoriteMoviesList")
    }

    func removeMovie(_ movie: PopularMovie) {
        favMoviesData.removeValue(forKey: movie.title)
        defaults.set(favMoviesData, forKey: "favoriteMoviesList")
    }

    func isFavorite(_ movie: PopularMovie) -> Bool {
        if favMoviesData[movie.title] != nil {
            return true
        } else {
            return false
        }
    }
}

extension FavMovieCache {
    func movieToData(movie: PopularMovie) -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movie)
            return data
        } catch {
            fatalError("Unable to encode movie to data.")
        }
    }

    func dataToMovie(data: Data) -> PopularMovie {
        let decoder = JSONDecoder()
        do {
            let movie = try decoder.decode(PopularMovie.self, from: data)
            return movie
        } catch {
            fatalError("Unable to decode data.")
        }
    }
}
