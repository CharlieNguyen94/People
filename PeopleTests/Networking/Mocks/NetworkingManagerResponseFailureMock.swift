import Foundation
@testable import People

class NetworkingManagerResponseFailureMock: NetworkingManagerProvider {
	func request<T>(session: URLSession, _ endpoint: People.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
		throw NetworkingManager.NetworkingError.invalidUrl
	}

	func request(session: URLSession, _ endpoint: People.Endpoint) async throws {}
}
