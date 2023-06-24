import XCTest
@testable import People

final class CreateViewModelValidationFailureTests: XCTestCase {

	private var networkingMock: NetworkingManagerProvider!
	private var validationMock: CreateValidatorProvider!
	private var viewModel: CreateViewModel!

	override func setUp() {
		networkingMock = NetworkingManagerCreateSuccessMock()
		validationMock = CreateValidatorFailureMock()
		viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock) {}
	}

	override func tearDown() {
		networkingMock = nil
		validationMock = nil
		viewModel = nil
	}

	func testWithInvalidForSubmissionStateIsInvalid() async {
		XCTAssertNil(viewModel.state, "The view model state should be nil initially")

		defer { XCTAssertEqual(viewModel.state, .unsuccessful, "The view model state should be unsuccessful") }

		await viewModel.create()

		XCTAssertTrue(viewModel.hasError, "The view model has an error")
		XCTAssertNotNil(viewModel.hasError, "The view model error property should not be nil")
		XCTAssertEqual(viewModel.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName), "The view model error should be invalid first name")
	}
}
