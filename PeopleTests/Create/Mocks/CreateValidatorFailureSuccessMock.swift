import Foundation
@testable import People

struct CreateValidatorFailureMock: CreateValidatorProvider {
	func validate(_ person: People.NewPerson) throws {
		throw CreateValidator.CreateValidatorError.invalidFirstName
	}
}
