import UIKit

protocol DataCacheType {
    var cache: [String: Data] { get set }
}

class FavMovieCache: DataCacheType {
    static var shared = FavMovieCache()
    private var defaults: UserDefaultsAdaptable
    var cache = [String: Data]()

    init(defaults: UserDefaultsAdaptable = UserDefaultsAdapter()) {
        self.defaults = defaults
        if let obj = self.defaults.object(forKey: Constants.favMovieListKey) as? [String: Data] {
            cache = obj
        }
    }

    func getFavList() -> [PopularMovie] {
        var favMovieList = [PopularMovie]()
        for dict in cache {
            let movie: PopularMovie = dataToObject(data: dict.value)
            favMovieList.append(movie)
        }
        return favMovieList
    }

    func addMovie(_ movie: PopularMovie) {
        let data = objectToData(object: movie)
        cache[movie.title] = data
        defaults.set(cache, forKey: Constants.favMovieListKey)
    }

    func removeMovie(_ movie: PopularMovie) {
        cache.removeValue(forKey: movie.title)
        defaults.set(cache, forKey: Constants.favMovieListKey)
    }

    func isFavorite(_ movie: PopularMovie) -> Bool {
        if cache[movie.title] != nil {
            return true
        } else {
            return false
        }
    }
}

extension FavMovieCache {
    func objectToData<T: Encodable>(object: T) throws -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            return data
        } catch {
            fatalError("Unable to encode movie to data.")
        }
    }

    func dataToObject<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            fatalError("Unable to decode data.")
        }
    }
}
