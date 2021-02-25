import UIKit

protocol FavoriteMoviesInteractable {
    func loadImage(from item: PopularMovie, into cell: FavoriteMovieCell)
}

class FavoriteMoviesInteractor: FavoriteMoviesInteractable{
    private var service: Service
    private let imageCache: Cache?

    init(service: Service = URLSessionService(), imageCache: Cache? = ImageCache.shared) {
        self.service = service
        self.imageCache = imageCache
    }

    func loadImage(from item: PopularMovie, into cell: FavoriteMovieCell) {
        guard let posterPath = item.posterPath else { return }
        if let image = imageCache?.getCache()[posterPath] {
            garanteeMainQueue {
                cell.movieImage.image = image
            }
        } else {
            let url = Endpoints.imageURL(from: posterPath)
            service.fetchImage(with: url) { result in
                switch result {
                case .success(let image):
                    self.garanteeMainQueue {
                        cell.movieImage.image = image
                    }
                case .failure(let error):
                    print(error)
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
