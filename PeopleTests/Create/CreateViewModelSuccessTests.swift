import XCTest
@testable import People

final class CreateViewModelSuccessTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var validationMock: CreateValidatorProvider!
	private var viewModel: CreateViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerCreateSuccessMock()
		validationMock = CreateValidatorSuccessMock()
		viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock) {}
	}

	override func tearDown() {
		networkingMock = nil
		validationMock = nil
		viewModel = nil
	}

	func testWithSuccessfulResponseSubmissionStateIsSuccessful() async throws {
		XCTAssertNil(viewModel.state, "The viewModel state should be nil initially")

		defer {
			XCTAssertEqual(viewModel.state, .successful, "The view model state should be successful")
		}

		await viewModel.create()
	}
}
