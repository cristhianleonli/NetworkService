import Foundation

public struct HttpResponse {
	
	// MARK: - Properties
	public var responseCode: Int
	public var data: Data?
	public var url: URL
	public var headerFields: HttpHeaders?
	
	// MARK: - Life Cycle
	public init(responseCode: Int, data: Data?, url: URL, headerFields: HttpHeaders?) {
		self.responseCode = responseCode
		self.data = data
		self.url = url
		self.headerFields = headerFields
	}
	
	public init(httpUrlResponse: HTTPURLResponse, url: URL, data: Data?) {
		self.responseCode = httpUrlResponse.statusCode
		self.data = data ?? Data()
		self.url = httpUrlResponse.url ?? url
		self.headerFields = httpUrlResponse.allHeaderFields as? [String: String]
	}
}

extension HttpResponse: CustomStringConvertible {
	public var description: String {
		let response: [String: String] = [
			"url": url.absoluteString,
			"code": "\(responseCode)",
			"headers": headerFields?.description ?? "[:]"
		]
		
		return response.description
	}
}
