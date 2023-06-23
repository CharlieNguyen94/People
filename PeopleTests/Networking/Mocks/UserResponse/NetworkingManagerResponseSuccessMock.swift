import Foundation
@testable import People

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerProvider {
	func request<T>(session: URLSession, _ endpoint: People.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
		return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T

	}

	func request(session: URLSession, _ endpoint: People.Endpoint) async throws {}
}
