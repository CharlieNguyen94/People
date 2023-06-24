import Foundation
@testable import People

struct CreateValidatorSuccessMock: CreateValidatorProvider {
	func validate(_ person: People.NewPerson) throws {}
}
