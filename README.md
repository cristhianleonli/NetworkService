# NetworkService

A description of this package.

```
func testExample() {
	let urlString = "https://jsonplaceholder.typicode.com/todos"

	let request = NetworkRequest(url: urlString)

	let observable: Observable<[TodoModel]> = NetworkService()
	.execute(request: request)

	let result = try? observable.toBlocking().first()
	XCTAssertEqual(result?.isEmpty, false)
}
```
