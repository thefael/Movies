import Foundation

protocol URLSessionAdaptable {
    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionAdaptedBunda: URLSessionAdaptable {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data =  data {
                completion(.success(data))
            }
        }.resume()
    }
}

