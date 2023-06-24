#if DEBUG
import Foundation

struct CreateValidatorFailureMock: CreateValidatorProvider {
	func validate(_ person: People.NewPerson) throws {
		throw CreateValidator.CreateValidatorError.invalidFirstName
	}
}
#endif
