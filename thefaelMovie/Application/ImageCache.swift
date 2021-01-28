import UIKit

class ImageCache {
    static var shared = ImageCache()
    var cache = [String: UIImage]()

    private init() {}
}
