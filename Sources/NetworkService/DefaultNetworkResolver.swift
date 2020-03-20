import RxSwift
import Foundation

internal class DefaultNetworkResolver {}

extension DefaultNetworkResolver: NetworkResolver {
	func execute<T: Decodable>(request: NetworkRequest) -> Observable<T> {
		guard
			let url = URL(string: request.url),
			let urlRequest = self.wrapRequest(request: request) else {
				return Observable<T>.error(ResponseError.wrongRequest)
		}
		
		return Observable<T>.create { dispose -> Disposable in
			let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
				let networkResponse: Result<T, ResponseError> = self.wrapResponse(url: url, data, response, error)
				switch networkResponse {
				case .success(let typedData):
					dispose.onNext(typedData)
				case .failure(let networkError):
					dispose.onError(networkError)
				}
			}
			
			task.resume()
			
			return Disposables.create {
				task.cancel()
			}
		}
	}
}

private extension DefaultNetworkResolver {
	func wrapResponse<T: Decodable>(url: URL, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, ResponseError> {
		guard let responseHttp = response as? HTTPURLResponse else {
			return .failure(ResponseError.noHttpResponse)
		}
		
		if let error = error {
			let errorResponse = HttpResponse(
				httpUrlResponse: responseHttp,
				url: url,
				data: data
			)
			return .failure(.network(error, errorResponse))
		}
		
		let successResponse = HttpResponse(
			httpUrlResponse: responseHttp,
			url: url,
			data: data
		)
		
		guard let typedData = T.parse(from: data) else {
			return .failure(.encoding(successResponse))
		}
		
		return .success(typedData)
	}
	
	func wrapRequest(request serviceRequest: NetworkRequest) -> URLRequest? {
		guard let url = URL(string: serviceRequest.url) else {
			return nil
		}
		
		var request = URLRequest(
			url: url,
			cachePolicy: .reloadIgnoringLocalCacheData,
			timeoutInterval: serviceRequest.timeout
		)
		
		request.httpMethod = serviceRequest.method.rawValue
		
		let headers = serviceRequest.headers ?? [:]
		
		for headerKey in headers.keys {
			request.setValue(headers[headerKey], forHTTPHeaderField: headerKey)
		}
		
		return request
	}
}
