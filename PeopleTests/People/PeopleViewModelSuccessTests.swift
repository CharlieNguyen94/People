import XCTest
@testable import People

final class PeopleViewModelSuccessTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var viewModel: PeopleViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerUserResponseSuccessMock()
		viewModel = PeopleViewModel(networkingManager: networkingMock)
	}

	override func tearDown() {
		networkingMock = nil
		viewModel = nil
	}

	func testWithSuccessfulResponseUsersArrayIsSet() async throws {

		XCTAssertFalse(viewModel.isLoading, "The viewModel should not be loading any data")
		defer {
			XCTAssertFalse(viewModel.isLoading, "The viewModel should not be loading any data")
			XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
		}
		await viewModel.fetchUsers()

		XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")
	}

	func testWithSuccessfulPaginatedResponseUsersArrayIsSet() async throws {
		XCTAssertFalse(viewModel.isLoading, "The viewModel should not be loading any data")

		defer {
			XCTAssertFalse(viewModel.isFetching, "The viewModel should not be fetching any data")
			XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
		}

		await viewModel.fetchUsers()

		XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")

		await viewModel.fetchNextSetOfUsers()

		XCTAssertEqual(viewModel.users.count, 12, "There should be 12 users within our data array")

		XCTAssertEqual(viewModel.page, 2, "The page should be 2")

	}

	func testWithResetCalledValuesIsReset() async throws {

		defer {
			XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")
			XCTAssertEqual(viewModel.page, 1, "The page should be 1")
			XCTAssertEqual(viewModel.totalPages, 2, "The total pages should be 2")
			XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
			XCTAssertFalse(viewModel.isLoading, "The view model should not be loading any data")
		}

		await viewModel.fetchUsers()

		XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")

		await viewModel.fetchNextSetOfUsers()

		XCTAssertEqual(viewModel.page, 2, "The page should be 2")

		await viewModel.fetchUsers()
	}

	func testWithLastUserFuncReturnsTrue() async {

		await viewModel.fetchUsers()

		let userData = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)

		let hasReachedEnd = viewModel.hasReachedEnd(of: userData.data.last!)

		XCTAssertTrue(hasReachedEnd, "The last user should match")
	}
}
