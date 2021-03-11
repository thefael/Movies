@testable import thefaelMovie
import UIKit

class ImageCacheMock: ImageCacheType {
    static let shared = ImageCacheMock()
    var cache = [String: UIImage]()

    private init() {}
}
