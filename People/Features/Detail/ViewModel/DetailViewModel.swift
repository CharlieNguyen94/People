import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	let userId: Int

	init(userId: Int) {
		self.userId = userId
	}

	func fetchDetails() {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users/\(userId)",
			type: UserDetailResponse.self
		) { [weak self] result in

			DispatchQueue.main.async {
				switch result {
				case .success(let response):
					self?.userDetails = response
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
