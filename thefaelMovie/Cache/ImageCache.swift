import UIKit

protocol Cache {
    func getCache() -> [String: UIImage]
}

class ImageCache: Cache {
    static var shared = ImageCache()
    var cache = [String: UIImage]()

    private init() {}

    func getCache() -> [String: UIImage] {
        return cache
    }
}
