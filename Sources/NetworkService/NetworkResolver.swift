import RxSwift
import Foundation

public protocol NetworkResolver {
    /**
     Execute a service call based in serviceRequest parameters.
     Needs to execute serviceRequest's success or failure block passing all the data returned by
     the server on a serviceResult object
     */
	func execute<T: Decodable>(request: NetworkRequest) -> Observable<T>
}
