@testable import thefaelMovie
import XCTest

class URLSessionServiceTests: XCTestCase {

    let urlSessionAdapter = URLSessionAdapterMock()
    lazy var service = URLSessionService(decoder: JSONDecoder(), session: urlSessionAdapter)
    var result: Result<UIImage, Error>?
    let url = URL(string: "https://conteudo.imguol.com.br/c/noticias/f1/2019/11/02/a-nasa-elegeu-como-foto-astronomica-do-dia-em-22-de-outubro-esta-imagem-da-via-lactea-capturada-por-jheison-huerta-no-salar-de-uyuni-na-bolivia-1572723035380_v2_900x506.jpg")!

    func test_fetchImage_whenSessionFetchDataIsFailure_shouldCallCompletionWithCorrectError() {
        service.fetchImage(with: url) { r in
            self.result = r
        }

        urlSessionAdapter.fetchDataArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try result?.get() }
        catch let e { error = e as? TestError }

        XCTAssertEqual(error, TestError.error)
    }

    func test_fetchImage_whenSessionFetchDataIsSuccess_shouldCallCompletionWithCorrectImage() {
        service.fetchImage(with: url) { r in
            self.result = r
        }

        if let data = try? NSData(contentsOf: url) as Data, let image = UIImage(data: data) {
            urlSessionAdapter.fetchDataArgs?.completion(.success(data))
            let imageData = (try? result?.get())?.pngData()
            let imageData2 = image.pngData()
            XCTAssertEqual(imageData, imageData2)
        } else {
            XCTFail()
        }
    }
}
