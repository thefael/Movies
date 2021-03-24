import UIKit

protocol FavoriteMoviesInteractable {
    func loadImage(from item: PopularMovie, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class FavoriteMoviesInteractor: FavoriteMoviesInteractable{
    private var service: Service
    private let imageCache: ImageCacheType?

    init(service: Service = URLSessionService(), imageCache: ImageCacheType? = ImageCache.shared) {
        self.service = service
        self.imageCache = imageCache
    }

    func loadImage(from item: PopularMovie, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let posterPath = item.posterPath else {
            completion(.failure(CommonError.noPosterPath))
            return
        }
        if let image = imageCache?.cache[posterPath] {
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
}
