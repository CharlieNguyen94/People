import Foundation

final class CreateViewModel: ObservableObject {

	@Published private(set) var state: SubmissionState?
	@Published private(set) var error: FormError?
	@Published var hasError = false
	@Published var person = NewPerson()

	private let validator = CreateValidator()

	let successfulAction: () -> Void

	init(successfulAction: @escaping () -> Void) {
		self.successfulAction = successfulAction
	}

	var shouldDisable: Bool {
		state == .submitting
	}

	@MainActor
	func create() async {

		do {

			try validator.validate(person)

			state = .submitting

			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try encoder.encode(person)

			try await NetworkingManager.shared.request(.create(submissionData: data))

			state = .successful

		} catch {
			self.hasError = true
			self.state = .unsuccessful

			switch error {
			case is NetworkingManager.NetworkingError:
				self.error = .networking(error: error as! NetworkingManager.NetworkingError)
			case is CreateValidator.CreateValidatorError:
				self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
			default:
				self.error = .system(error: error)
			}
		}
	}
}

extension CreateViewModel {
	enum SubmissionState {
		case unsuccessful
		case submitting
		case successful
	}
}

extension CreateViewModel {
	enum FormError: LocalizedError {
		case networking(error: LocalizedError)
		case validation(error: LocalizedError)
		case system(error: Error)
	}
}

extension CreateViewModel.FormError {

	var errorDescription: String? {
		switch self {
		case .networking(let error), .validation(error: let error):
			return error.errorDescription
		case .system(let error):
			return error.localizedDescription
		}
	}
}
