import XCTest

final class CreateScreenUIValidTests: XCTestCase {

	private var app: XCUIApplication!

	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-people-networking-success":"1"]
		app.launch()
	}

	override func tearDown() {
		app = nil
	}

	func testWhenCreateIsTappedCreateViewIsPresented() {

		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		XCTAssertTrue(app.navigationBars["Create"].waitForExistence(timeout: 5))
		XCTAssertTrue(app.buttons["doneButton"].exists)
		XCTAssertTrue(app.buttons["submitButton"].exists)
		XCTAssertTrue(app.textFields["firstNameTextField"].exists)
		XCTAssertTrue(app.textFields["lastNameTextField"].exists)
		XCTAssertTrue(app.textFields["jobTextField"].exists)

	}

	func testWhenDoneIsTappedCreateViewIsDismissed() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let doneButton = app.buttons["doneButton"]
		XCTAssertTrue(doneButton.exists)

		doneButton.tap()

		XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "There should be a navigation bar with the title people")
	}
}
