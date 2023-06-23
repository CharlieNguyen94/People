import Foundation
@testable import People

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerProvider {
	func request<T>(session: URLSession, _ endpoint: People.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
		return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
	}

	func request(session: URLSession, _ endpoint: People.Endpoint) async throws {}
}
