import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
	@Published var hasError = false
	let userId: Int

	init(userId: Int) {
		self.userId = userId
	}

	@MainActor
	func fetchDetails() async {
		isLoading = true
		defer { isLoading = false }

		do {
			self.userDetails = try await NetworkingManager.shared.request(.detail(id: userId), type: UserDetailResponse.self)
		} catch {
			self.hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}
}
