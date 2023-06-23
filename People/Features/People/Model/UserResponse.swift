import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
	let page, perPage, total, totalPages: Int
	let data: [User]
	let support: Support
}
