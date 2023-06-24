import Foundation
@testable import People

class NetworkingManagerCreateFailureMock: NetworkingManagerProvider {
	func request<T>(session: URLSession, _ endpoint: People.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
		return Data() as! T
	}

	func request(session: URLSession, _ endpoint: People.Endpoint) async throws {
		throw NetworkingManager.NetworkingError.invalidUrl
	}
}
