@testable import thefaelMovie
import XCTest

class URLSessionServiceTests: XCTestCase {

    let urlSessionAdapter = URLSessionAdapterMock()
    lazy var service = URLSessionService(decoder: JSONDecoder(), session: urlSessionAdapter)
    var fetchImageResult: Result<UIImage, Error>?
    var fetchDataResult: Result<JSONObj, Error>?
    let url = URL(string: "hue")!


    func test_fetchData_whenSessionFetchDataIsFailure_shouldCallCompletionWithCorrectError() {
        fetchData()
        urlSessionAdapter.fetchDataArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try fetchDataResult?.get() }
        catch let e { error = e as? TestError }
        
        XCTAssertEqual(error, TestError.error)
    }

    func test_fetchData_whenSessionFetchDataIsSuccess_shouldCallCompletionWithCorrectObject() {
        fetchData()
        guard let data = JSONObj().data else {
            XCTFail()
            return
        }
        urlSessionAdapter.fetchDataArgs?.completion(.success(data))
        let decodedData = try? JSONDecoder().decode(JSONObj.self, from: data)
        let obj = try? fetchDataResult?.get()

        XCTAssertEqual(obj, decodedData)
    }

    func test_fetchData_whenDecodeDataIsFailure_shouldCallCompletionWithCorrectError() {
        fetchData()
        let invalidData = Data()
        urlSessionAdapter.fetchDataArgs?.completion(.success(invalidData))
        var error: CommonError?
        do { let _ = try fetchDataResult?.get() }
        catch let e { error = e as? CommonError }

        XCTAssertEqual(error, .failToDecodeData)
    }

    func test_fetchImage_whenSessionFetchDataIsFailure_shouldCallCompletionWithCorrectError() {
        fetchImage()
        urlSessionAdapter.fetchDataArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try fetchImageResult?.get() }
        catch let e { error = e as? TestError }

        XCTAssertEqual(error, TestError.error)
    }

    func test_fetchImage_whenSessionFetchDataIsSuccess_shouldCallCompletionWithCorrectImage() {
        fetchImage()
        if let data = UIImage(systemName: "heart")?.pngData(), let image = UIImage(data: data) {
            urlSessionAdapter.fetchDataArgs?.completion(.success(data))
            let imageData = (try? fetchImageResult?.get())?.pngData()
            let imageData2 = image.pngData()

            XCTAssertEqual(imageData, imageData2)
        } else {
            XCTFail()
        }
    }

    func test_fetchImage_whenDecodeDataIsFailure_shouldCallCompletionWithCorrectError() {
        fetchImage()
        let invalidData = Data()

        urlSessionAdapter.fetchDataArgs?.completion(.success(invalidData))
        var error: CommonError?
        do { let _ = try fetchImageResult?.get() }
        catch let e { error = e as? CommonError}

        XCTAssertEqual(error, CommonError.failToDecodeData)
    }

    func fetchImage() {
        service.fetchImage(with: url) { r in
           self.fetchImageResult = r
        }
    }

    func fetchData() {
        service.fetchData(with: url) { r in
            self.fetchDataResult = r
        }
    }
}

struct JSONObj: Codable, Equatable {
    let variable: Int

    init(_ variable: Int = 1) {
        self.variable = variable
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
