#if DEBUG
import Foundation

struct CreateValidatorSuccessMock: CreateValidatorProvider {
	func validate(_ person: People.NewPerson) throws {}
}
#endif
