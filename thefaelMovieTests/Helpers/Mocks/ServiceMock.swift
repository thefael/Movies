@testable import thefaelMovie
import UIKit

class ServiceMock<U>: Service {
    var fetchDataArgs: (url: URL, completion: (Result<U, Error>) -> Void)?
    var fetchImageArgs: (url: URL, completion: (Result<UIImage, Error>) -> Void)?

    func fetchData<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        fetchDataArgs = (url: url, completion: completion as! (Result<U, Error>) -> Void)
    }

    func fetchImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        fetchImageArgs = (url, completion)
    }
}
