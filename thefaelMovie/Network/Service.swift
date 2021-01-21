import UIKit

class Service {
    private let decoder = JSONDecoder()
    private let session = URLSession.shared

    func fetchData<T: Decodable>(with url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let obj = try self.decoder.decode(T.self, from: data)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }

    func fetchImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        let imageTask = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data =  data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
        imageTask.resume()
    }
}
