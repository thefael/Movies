@testable import thefaelMovie
import UIKit

class FavMovieCacheMock: DataCacheType {
    var cache: [String: Data]

    var didCallGetFavList = false
    var didCallAddMovie = false
    var didCallRemoveMovie = false
    var movieIsFavorite = false
    var movieIsValid = true

    init(cache: [String: Data]) {
        self.cache = cache
    }

    func getFavList() throws -> [PopularMovie] {
        didCallGetFavList = true
        return [MovieGenerator.popularMovie]
    }

    func addMovie(_ movie: PopularMovie) throws {
        if !movieIsValid {
            throw TestError.error
        }
        didCallAddMovie = true
    }

    func removeMovie(_ movie: PopularMovie) {
        didCallRemoveMovie = true
    }

    func isFavorite(_ movie: PopularMovie) -> Bool {
        return movieIsFavorite
    }


}
