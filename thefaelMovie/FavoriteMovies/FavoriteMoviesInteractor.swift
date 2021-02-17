import UIKit

protocol FavoriteMoviesInteractable {
    func loadImage(from item: PopularMovie, into cell: FavoriteMovieCell)
}

class FavoriteMoviesInteractor: FavoriteMoviesInteractable{
    private var service: Service

    init(service: Service = URLSessionService()) {
        self.service = service
    }

    func loadImage(from item: PopularMovie, into cell: FavoriteMovieCell) {
        guard let posterPath = item.posterPath else { return }
        let imageCache = ImageCache.shared
        if let image = imageCache.cache[posterPath] {
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        } else {
            let service = URLSessionService()
            let url = Endpoints.imageURL(from: posterPath)
            service.fetchImage(with: url) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.movieImage.image = image
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
