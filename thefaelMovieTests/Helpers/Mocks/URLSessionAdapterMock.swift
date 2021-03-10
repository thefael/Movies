@testable import thefaelMovie
import UIKit

class URLSessionAdapterMock: URLSessionAdaptable {
    var fetchDataArgs: (url: URL, completion: ((Result<Data, Error>) -> Void))?
    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        fetchDataArgs = (url, completion)
    }
}
