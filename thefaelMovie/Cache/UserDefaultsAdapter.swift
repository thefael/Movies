import Foundation

protocol UserDefaultsAdaptable {
    var defaults: UserDefaults { get set }
    func set(_ value: Any?, forKey: String)
    func object(forKey: String) -> Any?
}

class UserDefaultsAdapter: UserDefaultsAdaptable {
    var defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    func set(_ value: Any?, forKey: String) {
        defaults.set(value, forKey: forKey)
    }

    func object(forKey: String) -> Any? {
        return defaults.object(forKey: forKey)
    }
}
