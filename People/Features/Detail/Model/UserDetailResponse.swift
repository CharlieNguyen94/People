import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
	let data: User
	let support: Support
}
