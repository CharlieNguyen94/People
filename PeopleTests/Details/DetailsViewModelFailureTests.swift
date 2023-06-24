import XCTest
@testable import People

final class DetailsViewModelFailureTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var viewModel: DetailViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerUserDetailsResponseFailureMock()
		viewModel = DetailViewModel(networkingManager: networkingMock)
	}

	override func tearDown() {
		networkingMock = nil
		viewModel = nil
	}

	func testWithUnsuccessfulResponseErrorIsHandlede() async {

		XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")

		defer {
			XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
		}

		await viewModel.fetchDetails(userId: 1)

		XCTAssertTrue(viewModel.hasError, "The view model error should be true")
		XCTAssertNotNil(viewModel.error, "The view model should not be nil")
	}
}
