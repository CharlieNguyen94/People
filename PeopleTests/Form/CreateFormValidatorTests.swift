import XCTest
@testable import People

class CreateFormValidatorTests: XCTestCase {

	private var validator: CreateValidator!

	override func setUp() {
		validator = CreateValidator()
	}

	override func tearDown() {
		validator = nil
	}

	func testWithEmptyPersonFirstNameErrorThrown() {
		let person = NewPerson()
		XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")

		do {
			_ = try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Got the wrong type of error expecting a create validator error")
				return
			}

			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
		}
	}

	func testWithEmptyFirstNameErrorThrown() {
		let person = NewPerson(lastName: "Joe", job: "Builder")
		XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")

		do {
			_ = try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Got the wrong type of error expecting a create validator error")
				return
			}

			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
		}
	}

	func testWithEmptyLastNameErrorThrown() {
		let person = NewPerson(firstName: "Anh", job: "Nails")
		XCTAssertThrowsError(try validator.validate(person), "Error for an empty last should be thrown")

		do {
			_ = try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Got the wrong type of error expecting a create validator error")
				return
			}

			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Expecting an error where we have invalid last name")
		}
	}

	func testWithEmptyJobErrorThrown() {
		let person = NewPerson(firstName: "Charlie", lastName: "Nguyen")
		XCTAssertThrowsError(try validator.validate(person), "Error for an empty job should be thrown")

		do {
			_ = try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Got the wrong type of error expecting a create validator error")
				return
			}

			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Expecting an error where we have invalid job")
		}
	}

	func testWithValidPersonErrorNotThrown() {
		let person = NewPerson(firstName: "Tommy", lastName: "Nguyen", job: "Personal Trainer")
		XCTAssertNoThrow(try validator.validate(person), "Error for valid person should not be thrown")

		do {
			_ = try validator.validate(person)
		} catch {
			XCTFail("No error should be thrown, since the person is a valid object")
		}
	}
}

