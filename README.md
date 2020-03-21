# NetworkService

This package uses:
- RxSwift 5.1.0

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
