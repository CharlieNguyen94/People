import Foundation

final class CreateViewModel: ObservableObject {

	@Published private(set) var state: SubmissionState?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false
	@Published var person = NewPerson()

	func create() {

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
							self.error = error as? NetworkingManager.NetworkingError
						}
					}
				}
	}
}

extension CreateViewModel {
	enum SubmissionState {
		case unsuccessful
		case successful
	}
}
