# NetworkService

This module wraps network service calls, it takes a `NetworkRequest` and executes it. It uses RxSwift to return the fetched data. To transform the response data, the observable type must be specified, once the data successfully comes back from the network call, it gets parsed using `Codable`.

`public init(resolver: NetworkResolver)`
`public func execute<T: Decodable>(request: NetworkRequest) -> Observable<T>`

As you can see in the init function, you can specify the `NetworkResolver` with which the network service will perform the network call. By default, it uses `DefaultNetworkResolver` which uses URLSession.

### NetworkRequest
It contains the definition of a request, here can be specified all the information the network call makes use of.

```swift
var url: String
var method: HttpMethod
var timeout: TimeInterval
var encoding: RequestEncoding
var headers: HttpHeaders?
```

### Built with
- RxSwift 5.1.0

### Sample

```swift
func testExample() {
	let urlString = "https://jsonplaceholder.typicode.com/todos"

	let request = NetworkRequest(url: urlString)

	let observable: Observable<[TodoModel]> = NetworkService()
		.execute(request: request)
		
	observable.subscribe(
		onNext: { list in
			print(list)
		},
		onError: { error in
			let responseError = error as? ResponseError
			switch responseError {
			case .encoding(let response):
				print(response)
			default:
				break
			}
		})
		.disposed(by: disposeBag)
		
	let result = try? observable.toBlocking().first()
	XCTAssertEqual(result?.isEmpty, false)
}
```
