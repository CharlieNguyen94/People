import XCTest

final class CreateScreenFormValidationTests: XCTestCase {

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

	func testWhenAllFormFieldIsEmptyFirstNameErrorIsShown() {

		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on the screen")

		submitButton.tap()

		let alert = app.alerts.firstMatch
		let alertButton = alert.buttons.firstMatch

		XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
		XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
		XCTAssertEqual(alertButton.label, "OK")

		alertButton.tap()

		XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func testWhenFirstNameFormFieldIsEmptyFirstNameErrorIsShown() {

		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let lastNameTextField = app.textFields["lastNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		lastNameTextField.tap()
		lastNameTextField.typeText("Nguyen")

		jobTextField.tap()
		jobTextField.typeText("iOS Developer")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on the screen")

		submitButton.tap()

		let alert = app.alerts.firstMatch
		let alertButton = alert.buttons.firstMatch

		XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
		XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
		XCTAssertEqual(alertButton.label, "OK")

		alertButton.tap()

		XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func testWhenLastNameFormFieldIsEmptyLastNameErrorIsShown() {

		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		firstNameTextField.tap()
		firstNameTextField.typeText("Charlie")

		jobTextField.tap()
		jobTextField.typeText("iOS Developer")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on the screen")

		submitButton.tap()

		let alert = app.alerts.firstMatch
		let alertButton = alert.buttons.firstMatch

		XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
		XCTAssertTrue(alert.staticTexts["Last name can't be empty"].exists)
		XCTAssertEqual(alertButton.label, "OK")

		alertButton.tap()

		XCTAssertTrue(app.staticTexts["Last name can't be empty"].exists)
		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func testWhenJobFormFieldIsEmptyJobErrorIsShown() {

		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")

		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let lastNameTextField = app.textFields["lastNameTextField"]

		firstNameTextField.tap()
		firstNameTextField.typeText("Charlie")

		lastNameTextField.tap()
		lastNameTextField.typeText("Nguyen")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on the screen")

		submitButton.tap()

		let alert = app.alerts.firstMatch
		let alertButton = alert.buttons.firstMatch

		XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
		XCTAssertTrue(alert.staticTexts["Job can't be empty"].exists)
		XCTAssertEqual(alertButton.label, "OK")

		alertButton.tap()

		XCTAssertTrue(app.staticTexts["Job can't be empty"].exists)
		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}
}
