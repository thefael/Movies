import UIKit

protocol ImageCacheType {
    var cache: [String: UIImage] { get set }
}

class ImageCache: ImageCacheType {
    static var shared = ImageCache()
    var cache = [String: UIImage]()

    private init() {}
}
