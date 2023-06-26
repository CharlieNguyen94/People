import XCTest
@testable import People

class PeopleViewModelFailureTests: XCTest {

	private var networkingMock: NetworkingManagerProvider!
	private var viewModel: PeopleViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerResponseFailureMock()
		viewModel = PeopleViewModel(networkingManager: networkingMock)
	}

	override func tearDown() {
		networkingMock = nil
		viewModel = nil
	}

	func testWithUnsuccessfulResponseErrorIsHandled() async {
		XCTAssertFalse(viewModel.isLoading, "The viewModel should not be loading any data")

		defer {
			XCTAssertFalse(viewModel.isLoading, "The viewModel should not be loading any data")
			XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
		}

		await viewModel.fetchUsers()

		XCTAssertTrue(viewModel.hasError, "The view model should have an error")
		XCTAssertNotNil(viewModel.error, "The view model error should be set")
	}
}
