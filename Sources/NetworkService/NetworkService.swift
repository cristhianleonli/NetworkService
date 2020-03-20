import Foundation
import RxSwift

public class NetworkService {
	
	private var resolver: NetworkResolver = DefaultNetworkResolver()
	
	public init() {}
	
	public init(resolver: NetworkResolver) {
		self.resolver = resolver
	}
}

extension NetworkService {
	public func execute<T: Decodable>(request: NetworkRequest) -> Observable<T> {
		return resolver.execute(request: request)
	}
}
