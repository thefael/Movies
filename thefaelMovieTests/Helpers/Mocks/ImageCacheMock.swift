@testable import thefaelMovie
import UIKit

class ImageCacheMock: Cache {
    static let shared = ImageCacheMock()
    var cache = [String: UIImage]()

    private init() {}

    func getCache() -> [String : UIImage] {
        return cache
    }
}
