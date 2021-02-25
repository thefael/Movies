import UIKit

protocol FavoriteMoviesInteractable {
    func loadImage(from item: PopularMovie, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class FavoriteMoviesInteractor: FavoriteMoviesInteractable{
    private var service: Service
    private let imageCache: Cache?

    init(service: Service = URLSessionService(), imageCache: Cache? = ImageCache.shared) {
        self.service = service
        self.imageCache = imageCache
    }

    func loadImage(from item: PopularMovie, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let posterPath = item.posterPath else { return }
        if let image = imageCache?.getCache()[posterPath] {
            completion(.success(image))
        } else {
            let url = Endpoints.imageURL(from: posterPath)
            service.fetchImage(with: url) { result in
                switch result {
                case .success(let image):
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func garanteeMainQueue(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async { work() }
        }
    }
}
