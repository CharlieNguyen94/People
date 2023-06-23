import Foundation

final class DetailViewModel: ObservableObject {

	@Published private(set) var userDetails: UserDetailResponse?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
	@Published var hasError = false

	private let userId: Int
	private let networkingManager: NetworkingManagerProvider

	init(userId: Int, networkingManager: NetworkingManagerProvider = NetworkingManager.shared) {
		self.userId = userId
		self.networkingManager = networkingManager
	}

	@MainActor
	func fetchDetails() async {
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
