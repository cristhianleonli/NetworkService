import XCTest
import RxSwift
import RxBlocking
import NetworkService

final class NetworkServiceTests: XCTestCase {
    func testExample() {
		let urlString = "https://jsonplaceholder.typicode.com/todos"
		
		let request = NetworkRequest(url: urlString)
		
		let observable: Observable<[TodoModel]> = NetworkService()
			.execute(request: request)
			
		let result = try? observable.toBlocking().first()
		XCTAssertEqual(result?.isEmpty, false)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
	
	struct TodoModel: Decodable {
		let id: Int
		let userId: Int
		let title: String
		let completed: Bool
	}
}
