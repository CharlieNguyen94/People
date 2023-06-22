import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false
	let userId: Int

	init(userId: Int) {
		self.userId = userId
	}

	func fetchDetails() {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users/\(userId)",
			type: UserDetailResponse.self
		) { [weak self] result in
			guard let self else { return }

			DispatchQueue.main.async {
				switch result {
				case .success(let response):
					self.userDetails = response
				case .failure(let error):
					self.hasError = true
					self.error = error as? NetworkingManager.NetworkingError
				}
			}
		}
	}
}
