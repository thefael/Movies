import UIKit

class GenresViewController: UIViewController {
    let service = Service()
    var genreList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(Endpoints.brGenreListURL)
        service.fetchData(with: Endpoints.brGenreListURL) { (result: Result<Genres, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                for genre in data.genres {
                    self.genreList.append(genre.name)
                }
            }
        }
    }
}

