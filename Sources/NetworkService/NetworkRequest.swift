import Foundation

public typealias HttpHeaders = [String: String]

public class NetworkRequest {
	
	// MARK: - Properties
	public var url: String
	public var method: HttpMethod
	public var timeout: TimeInterval
	public var encoding: RequestEncoding
	public var headers: HttpHeaders?
	
	// MARK: - Life Cycle
	public init(
		url: String,
		method: HttpMethod = .get,
		timeout: TimeInterval = 10.0,
		encoding: RequestEncoding = .json,
		headers: HttpHeaders? = nil
	) {
		self.url = url
		self.method = method
		self.timeout = timeout
		self.encoding = encoding
		self.headers = headers
	}
}
