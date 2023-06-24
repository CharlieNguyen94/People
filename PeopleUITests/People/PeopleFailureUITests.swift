import XCTest

final class PeopleFailureUITests: XCTestCase {

	private var app: XCUIApplication!

	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-people-networking-success":"0"]
		app.launch()
	}

	override func tearDown() {
		app = nil
	}

	func testAlertIsShownWhenScreenFailsToLoads() {

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert on the screen")

		XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
		XCTAssertTrue(alert.buttons["Retry"].exists)
	}
}
