import UIKit

class FavMovieCache {
    static var shared = FavMovieCache()
    var cache = [PopularMovie]()

    private init() {}
}
