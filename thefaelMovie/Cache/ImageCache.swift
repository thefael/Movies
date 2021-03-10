import UIKit

protocol Cache {
    var cache: [String: UIImage] { get set }
}

class ImageCache: Cache {
    static var shared = ImageCache()
    var cache = [String: UIImage]()

    private init() {}
}
