import Foundation

final class CreateViewModel: ObservableObject {

	@Published private(set) var state: SubmissionState?
	@Published private(set) var error: FormError?
	@Published var hasError = false
	@Published var person = NewPerson()

	private let networkingManager: NetworkingManagerProvider
	private let validator: CreateValidatorProvider

	init(
		networkingManager: NetworkingManagerProvider = NetworkingManager.shared,
		validator: CreateValidatorProvider = CreateValidator()
	) {
		self.networkingManager = networkingManager
		self.validator = validator
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

			try await networkingManager.request(session: .shared, .create(submissionData: data))

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

extension CreateViewModel.FormError: Equatable {
	static func == (lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
		switch (lhs, rhs) {
		case (.networking(let lhsType), .networking(let rhsType)):
			return lhsType.errorDescription == rhsType.errorDescription
		case (.validation(let lhsType), .validation(let rhsType)):
			return lhsType.errorDescription == rhsType.errorDescription
		case (.system(let lhsType), .system(let rhsType)):
			return lhsType.localizedDescription == rhsType.localizedDescription
		default :
			return false
		}
	}
}
