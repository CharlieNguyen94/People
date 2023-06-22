import Foundation

final class PeopleViewModel: ObservableObject {

	@Published private(set) var users = [User]()
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false
	@Published var showCreate = false

	func fetchUsers() {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users",
			type: UsersResponse.self
		) { [weak self] result in
			guard let self else { return }

			DispatchQueue.main.async {
				switch result {
				case .success(let response):
					self.users = response.data
				case .failure(let error):
					self.hasError = true
					self.error = error as? NetworkingManager.NetworkingError
				}
			}
		}
	}
}
