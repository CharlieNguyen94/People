import XCTest

final class PeopleScreenUITests: XCTestCase {

	private var app: XCUIApplication!

	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-networking-success":"1"]
		app.launch()
	}

	override func tearDown() {
		app = nil
	}

	func testGridHasCorrectNumberOfItemsWhenScreenLoads() {

		let grid = app.otherElements["peopleGrid"]
		XCTAssertTrue(grid.waitForExistence(timeout: 5), "The people lazygrid should be visible")

		let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
		let gridItems = grid.buttons.containing(predicate)

		// if test fails po grid.children(matching: .any) to find correct UI element
		XCTAssertEqual(gridItems.count, 6, "There should be six items on the screen")

		XCTAssertTrue(gridItems.staticTexts["#1"].exists)
		XCTAssertTrue(gridItems.staticTexts["George Bluth"].exists)

		XCTAssertTrue(gridItems.staticTexts["#2"].exists)
		XCTAssertTrue(gridItems.staticTexts["Janet Weaver"].exists)

		XCTAssertTrue(gridItems.staticTexts["#3"].exists)
		XCTAssertTrue(gridItems.staticTexts["Emma Wong"].exists)

		XCTAssertTrue(gridItems.staticTexts["#4"].exists)
		XCTAssertTrue(gridItems.staticTexts["Eve Holt"].exists)

		XCTAssertTrue(gridItems.staticTexts["#5"].exists)
		XCTAssertTrue(gridItems.staticTexts["Charles Morris"].exists)

		XCTAssertTrue(gridItems.staticTexts["#6"].exists)
		XCTAssertTrue(gridItems.staticTexts["Tracey Ramos"].exists)
	}
}
