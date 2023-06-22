import Foundation

final class PeopleViewModel: ObservableObject {

	@Published private(set) var users = [User]()
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading: Bool = false
	@Published var hasError = false
	@Published var showCreate = false
	@Published var shouldShowSuccess = false


	func fetchUsers() {
		isLoading = true
		NetworkingManager.shared.request(
			"https://reqres.in/api/users",
			type: UsersResponse.self
		) { [weak self] result in
			guard let self else { return }

			DispatchQueue.main.async {
				defer { self.isLoading = false }
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
