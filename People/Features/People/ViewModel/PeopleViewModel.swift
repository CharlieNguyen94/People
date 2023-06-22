import Foundation

final class PeopleViewModel: ObservableObject {

	@Published private(set) var users = [User]()
	@Published var showCreate = false

	func fetchUsers() {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users",
			type: UsersResponse.self
		) { [weak self] result in

			DispatchQueue.main.async {
				switch result {
				case .success(let response):
					self?.users = response.data
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
