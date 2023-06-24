import XCTest
@testable import People

final class CreateViewModelFailureTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var validationMock: CreateValidatorProvider!
	private var viewModel: CreateViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerCreateFailureMock()
		validationMock = CreateValidatorSuccessMock()
		viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock) {}
	}

	override func tearDown() {
		networkingMock = nil
		validationMock = nil
		viewModel = nil
	}

	func testWithUnsuccessfulResponseSubmissionStateIsUnsuccessful() async throws {

		XCTAssertNil(viewModel.state, "The view model state should be nil")

		defer { XCTAssertEqual(viewModel.state, .unsuccessful, "The view model state should be unsuccessful") }

		await viewModel.create()

		XCTAssertTrue(viewModel.hasError, "The view model should have an error")
		XCTAssertNotNil(viewModel.error, "The view model error should not be nil")
		XCTAssertEqual(viewModel.error, .networking(error: NetworkingManager.NetworkingError.invalidUrl), "The view model error shold be a networking with an invalid url")
	}
}
