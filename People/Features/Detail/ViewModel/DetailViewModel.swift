import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading: Bool = false
	@Published var hasError = false
	let userId: Int

	init(userId: Int) {
		self.userId = userId
	}

	func fetchDetails() {
		isLoading = true
		NetworkingManager.shared.request(
			"https://reqres.in/api/users/\(userId)",
			type: UserDetailResponse.self
		) { [weak self] result in
			guard let self else { return }

			DispatchQueue.main.async {
				defer { self.isLoading = false }
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
