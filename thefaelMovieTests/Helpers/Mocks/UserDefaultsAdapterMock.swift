@testable import thefaelMovie
import Foundation

class UserDefaultsAdapterMock: UserDefaultsAdaptable {
    var cache: [String : Data] = [String: Data]()

    var didCallSet = false
    var didCallObject = false

    func set(_ value: Any?, forKey: String) {
        didCallSet = true
    }

    func object(forKey: String) -> Any? {
        didCallObject = true
        return nil
    }
}
