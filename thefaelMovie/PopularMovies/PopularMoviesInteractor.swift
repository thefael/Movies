import UIKit

protocol Interactor {
    func loadMovieList(onSuccess: @escaping (([PopularMovie]) -> Void), onError: @escaping ((Error) -> Void))
}

class PopularMoviesInteractor: Interactor {
    let service: Service

    init(service: Service) {
        self.service = service
    }

    func loadMovieList(onSuccess: @escaping (([PopularMovie]) -> Void), onError: @escaping ((Error) -> Void)) {
        service.fetchData(with: Endpoints.popularMoviesListURL()) { (result: Result<PopularMovies, Error>) in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let movieList):
                onSuccess(movieList.movies)
            }
        }
    }
}
