import UIKit

protocol Service {
    func fetchData<T: Decodable>(with url: URL, completion: @escaping ((Result<T, Error>) -> Void))
    func fetchImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void))
}

class URLSessionService: Service {
    private let decoder: JSONDecoder
    private let session: URLSessionAdapter

    init(decoder: JSONDecoder = JSONDecoder(), session: URLSessionAdapter = URLSessionAdaptedBunda()) {
        self.decoder = decoder
        self.session = session
    }

    func fetchData<T: Decodable>(with url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        session.fetchData(url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let obj = try? self.decoder.decode(T.self, from: data) {
                    completion(.success(obj))
                } else {
                    completion(.failure(CommonError.failToDecodeData))
                }
            }
        }
    }

    func fetchImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        session.fetchData(url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(CommonError.failToDecodeData))
                }
            }
        }
    }
}
