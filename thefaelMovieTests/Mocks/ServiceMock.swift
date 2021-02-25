@testable import thefaelMovie
import UIKit

class ServiceMock<U>: Service {
    var fetchImageArgs: (url: URL, completion: (Result<UIImage, Error>) -> Void)?
    func fetchData<T>(with url: URL, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {}

    func fetchImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        fetchImageArgs = (url, completion)
    }

    
}
