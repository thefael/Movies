import UIKit

protocol ObjectSavable {
    func setObject<Object: Encodable>(_ object: Object, forKey: String)
    func getObject<Object: Decodable>(forKey: String, castTo: Object.Type) -> Object?
}

extension UserDefaults: ObjectSavable {

    func setObject<Object: Encodable>(_ object: Object, forKey key: String) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }

    func getObject<Object: Decodable>(forKey key: String, castTo: Object.Type) -> Object? {
        let decoder = JSONDecoder()
        guard let data = data(forKey: key), let object = try? decoder.decode(Object.self, from: data) else {
            fatalError(ObjectSavableError.unableToDecode.rawValue)
        }
        return object
    }
}

enum ObjectSavableError: String, Error {
    case unableToEncode = "Unable to encode object."
    case unableToDecode = "Unable to decode data."
    case noValue = "No value associated to data."

    var errorDescription: String? {
        rawValue
    }
}
