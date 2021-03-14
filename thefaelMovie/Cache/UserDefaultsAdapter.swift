import Foundation

protocol UserDefaultsAdaptable {
    var cache: [String: Data] { get set }
    func set(_ value: Any?, forKey: String)
    func object(forKey: String) -> Any?
}

class UserDefaultsAdapter: UserDefaultsAdaptable {
    var cache: [String : Data]
    var defaults: UserDefaults

    init(cache: [String: Data] = [String: Data](), defaults: UserDefaults = UserDefaults.standard) {
        self.cache = cache
        self.defaults = defaults
    }

    func set(_ value: Any?, forKey: String) {
        defaults.set(value, forKey: forKey)
    }

    func object(forKey: String) -> Any? {
        return defaults.object(forKey: forKey)
    }
}
