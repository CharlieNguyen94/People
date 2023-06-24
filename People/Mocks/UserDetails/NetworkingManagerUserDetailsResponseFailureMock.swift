#if DEBUG
import Foundation

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerProvider {
	func request<T>(session: URLSession, _ endpoint: People.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
		throw NetworkingManager.NetworkingError.invalidUrl
	}

	func request(session: URLSession, _ endpoint: People.Endpoint) async throws {}
}
#endif
