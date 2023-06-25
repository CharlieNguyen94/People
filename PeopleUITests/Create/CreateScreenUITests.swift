import XCTest

final class CreateScreenUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = [
			"-people-networking-success":"1",
			"-create-networking=success":"1"
		]
		app.launch()
	}

	override func tearDown() {
		app = nil
	}

	func testValidFormSubmissionIsSuccessful() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let lastNameTextField = app.textFields["lastNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		firstNameTextField.tap()
		firstNameTextField.typeText("Charlie")

		lastNameTextField.tap()
		lastNameTextField.typeText("Nguyen")

		jobTextField.tap()
		jobTextField.typeText("iOS Developer")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "The submit button should be visible on the screen")

		submitButton.tap()

		XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "There should be a navigation bar with the title people")
	}
}
