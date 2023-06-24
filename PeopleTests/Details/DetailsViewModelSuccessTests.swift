import XCTest
@testable import People

final class DetailsViewModelSuccessTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var viewModel: DetailViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerUserDetailsResponseSuccessMock()
		viewModel = DetailViewModel(networkingManager: networkingMock)
	}

	override func tearDown() {
		networkingMock = nil
		viewModel = nil
	}

	func testWithSuccessfulResponseUsersDetailsIsSet() async throws {

		XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")

		defer {
			XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
		}

		await viewModel.fetchDetails(userId: 1)

		XCTAssertNotNil(viewModel.userDetails, "The user info in the view model should not be nil")

		let userDetailsData = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)

		XCTAssertEqual(viewModel.userDetails, userDetailsData, "The response from our networking mock should match")
	}
}
