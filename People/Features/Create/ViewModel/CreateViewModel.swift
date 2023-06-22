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

	func create() {
		do {
			try validator.validate(person)

			state = .submitting

			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try? encoder.encode(person)

			NetworkingManager
				.shared
				.request(
					methodType: .POST(data: data),
					"https://reqres.in/api/users") { [weak self] result in
						guard let self else { return }

						DispatchQueue.main.async {
							switch result {
							case .success:
								self.state = .successful
							case .failure(let error):
								self.state = .unsuccessful
								self.hasError = true
								if let networkingError = error as? NetworkingManager.NetworkingError {
									self.error = .networking(error: networkingError)
								}
							}
						}
					}

		} catch {
			self.hasError = true
			if let validationError = error as? CreateValidator.CreateValidatorError {
				self.error = .validation(error: validationError)
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
	}
}

extension CreateViewModel.FormError {

	var errorDescription: String? {
		switch self {
		case .networking(let error), .validation(error: let error):
			return error.errorDescription
		}
	}
}
