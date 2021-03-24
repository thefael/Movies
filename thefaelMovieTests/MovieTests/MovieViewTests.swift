@testable import thefaelMovie
import FBSnapshotTestCase

class MovieViewTests: FBSnapshotTestCase {
    let imageCache = ImageCacheMock.shared

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func test_movieView_shouldLookLikeThis() {
        imageCache.cache["testPath"] = #imageLiteral(resourceName: "wonderwoman")
        let movieView = MovieView(frame: Constants.screen, movie: MovieGenerator.movieWithPath, cache: imageCache)
        movieView.setupView()

        FBSnapshotVerifyView(movieView)
    }
}
