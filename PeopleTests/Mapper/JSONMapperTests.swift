import Foundation
import XCTest
@testable import People

class JSONMapperTests: XCTestCase {

	func testWithValidJsonSuccessfullyDecodes() {
		XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self), "Mapper should not throw an error")

		let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
		XCTAssertNotNil(userResponse, "User response should not be nil")

		XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
		XCTAssertEqual(userResponse?.perPage, 6, "Page number should be 6")
		XCTAssertEqual(userResponse?.total, 12, "Total should be 12")
		XCTAssertEqual(userResponse?.totalPages, 2, "Total pages should be 2")

		XCTAssertEqual(userResponse?.data.count, 6, "The total number of users should be 6")

		XCTAssertEqual(userResponse?.data[0].id, 1, "First id should be 1")
		XCTAssertEqual(userResponse?.data[0].email, "george.bluth@reqres.in", "First email should be george.bluth@reqres.in")
		XCTAssertEqual(userResponse?.data[0].firstName, "George", "First name should be George")
		XCTAssertEqual(userResponse?.data[0].lastName, "Bluth", "Last name should be Bluth")
		XCTAssertEqual(userResponse?.data[0].avatar, "https://reqres.in/img/faces/1-image.jpg", "Avatar url should be https://reqres.in/img/faces/1-image.jpg")

		XCTAssertEqual(userResponse?.data[1].id, 2, "First id should be 2")
		XCTAssertEqual(userResponse?.data[1].email, "janet.weaver@reqres.in", "First email should be janet.weaver@reqres.in")
		XCTAssertEqual(userResponse?.data[1].firstName, "Janet", "First name should be Janet")
		XCTAssertEqual(userResponse?.data[1].lastName, "Weaver", "Last name should be Weaver")
		XCTAssertEqual(userResponse?.data[1].avatar, "https://reqres.in/img/faces/2-image.jpg", "Avatar url should be https://reqres.in/img/faces/2-image.jpg")

		XCTAssertEqual(userResponse?.data[2].id, 3, "First id should be 3")
		XCTAssertEqual(userResponse?.data[2].email, "emma.wong@reqres.in", "First email should be emma.wong@reqres.in")
		XCTAssertEqual(userResponse?.data[2].firstName, "Emma", "First name should be Emma")
		XCTAssertEqual(userResponse?.data[2].lastName, "Wong", "Last name should be Wong")
		XCTAssertEqual(userResponse?.data[2].avatar, "https://reqres.in/img/faces/3-image.jpg", "Avatar url should be https://reqres.in/img/faces/3-image.jpg")

		XCTAssertEqual(userResponse?.data[3].id, 4, "First id should be 4")
		XCTAssertEqual(userResponse?.data[3].email, "eve.holt@reqres.in", "First email should be eve.holt@reqres.in")
		XCTAssertEqual(userResponse?.data[3].firstName, "Eve", "First name should be Eve")
		XCTAssertEqual(userResponse?.data[3].lastName, "Holt", "Last name should be Holt")
		XCTAssertEqual(userResponse?.data[3].avatar, "https://reqres.in/img/faces/4-image.jpg", "Avatar url should be https://reqres.in/img/faces/4-image.jpg")

		XCTAssertEqual(userResponse?.data[4].id, 5, "First id should be 5")
		XCTAssertEqual(userResponse?.data[4].email, "charles.morris@reqres.in", "First email should be charles.morris@reqres.in")
		XCTAssertEqual(userResponse?.data[4].firstName, "Charles", "First name should be Charles")
		XCTAssertEqual(userResponse?.data[4].lastName, "Morris", "Last name should be Morris")
		XCTAssertEqual(userResponse?.data[4].avatar, "https://reqres.in/img/faces/5-image.jpg", "Avatar url should be https://reqres.in/img/faces/5-image.jpg")

		XCTAssertEqual(userResponse?.data[5].id, 6, "First id should be 6")
		XCTAssertEqual(userResponse?.data[5].email, "tracey.ramos@reqres.in", "First email should be tracey.ramos@reqres.in")
		XCTAssertEqual(userResponse?.data[5].firstName, "Tracey", "First name should be Tracey")
		XCTAssertEqual(userResponse?.data[5].lastName, "Ramos", "Last name should be Ramos")
		XCTAssertEqual(userResponse?.data[5].avatar, "https://reqres.in/img/faces/6-image.jpg", "Avatar url should be https://reqres.in/img/faces/6-image.jpg")

		XCTAssertEqual(userResponse?.support.url, "https://reqres.in/#support-heading", "Support url should be https://reqres.in/#support-heading")
		XCTAssertEqual(
			userResponse?.support.text,
			"To keep ReqRes free, contributions towards server costs are appreciated!",
			"Support text should be To keep ReqRes free, contributions towards server costs are appreciated!"
		)
	}

	func testWithMissingFileErrorThrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "An error should be thrown")
		do {
			_ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("This is the wrong type of error for missing files")
				return
			}
			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error.")
		}
	}

	func testWithMInvalidFileErrorThrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "invalid", type: UsersResponse.self), "An error should be thrown")
		do {
			_ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("This is the wrong type of error for missing files")
				return
			}
			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error.")
		}
	}

	func testWithInvalidJsonErrorThrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self), "An error should be thrown")

		do {
			_ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
		} catch {
			if error is StaticJSONMapper.MappingError {
				XCTFail("Got the wrong type of error, expecting a system decoding error")
			}
		}
	}
}
