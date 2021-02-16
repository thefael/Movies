import UIKit

protocol Interactor {
    func loadMovieLists(completion: @escaping ((Result<[PopularMovie], Error>) -> Void))
}

class PopularMoviesInteractor: Interactor {
    let service: Service

    init(service: Service = URLSessionService()) {
        self.service = service
    }

    func loadMovieLists(completion: @escaping ((Result<[PopularMovie], Error>) -> Void)) {
        service.fetchData(with: Endpoints.popularMoviesListURL()) { (result: Result<PopularMovies, Error>) in
            switch result {
            case .success(let movieList):
                completion(.success(movieList.movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
