import Foundation

final class CreateViewModel: ObservableObject {

	@Published var person = NewPerson()
	@Published private(set) var state: SubmissionState?

	func create() {

		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		let data = try? encoder.encode(person)

		NetworkingManager
			.shared
			.request(
				methodType: .POST(data: data),
				"https://reqres.in/api/users") { [weak self] result in

					DispatchQueue.main.async {
						switch result {
						case .success:
							self?.state = .successful
						case .failure(let error):
							self?.state = .unsuccessful
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
