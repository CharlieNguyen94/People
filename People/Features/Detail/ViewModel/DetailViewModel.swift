import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
	@Published var hasError = false

	private let networkingManager: NetworkingManagerProvider

	init(networkingManager: NetworkingManagerProvider = NetworkingManager.shared) {
		self.networkingManager = networkingManager
	}

	@MainActor
	func fetchDetails(userId: Int) async {
		isLoading = true
		defer { isLoading = false }

		do {
			self.userDetails = try await networkingManager.request(session: .shared, .detail(id: userId), type: UserDetailResponse.self)
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
