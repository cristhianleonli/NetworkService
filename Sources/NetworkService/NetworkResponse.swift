import Foundation

public enum ResponseError: Error {
	case noHttpResponse
	case wrongRequest
	case encoding(HttpResponse)
	case network(Error, HttpResponse)
}
