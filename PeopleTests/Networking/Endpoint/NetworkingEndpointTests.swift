import XCTest
@testable import People

final class NetworkingEndpointTests: XCTestCase {

	func testWithPeopleEndpointRequestIsValid() {

		let endpoint = Endpoint.people(page: 1)

		XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
		XCTAssertEqual(endpoint.queryItems, ["page":"1"], "The query items should be page 1")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=2", "The generated url does not match our endpoint")
	}

	func testWithDetailEndpointRequestIsValid() {

		let userId = 1
		let endpoint = Endpoint.detail(id: userId)

		XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
		XCTAssertNil(endpoint.queryItems, "The query items should be nil")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userId)?delay=2", "The generated url does not match our endpoint")

	}

	func testWithCreateEndpointRequestIsValid() {

		let endpoint = Endpoint.create(submissionData: nil)
		XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
		XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
		XCTAssertNil(endpoint.queryItems, "The query items should be nil")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=2", "The generated url does not match our endpoint")

	}
}
