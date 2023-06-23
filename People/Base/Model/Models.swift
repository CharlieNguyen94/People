import Foundation

// MARK: - DataClass
struct User: Codable, Identifiable, Equatable {
	let id: Int
	let email, firstName, lastName: String
	let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
	let url: String
	let text: String
}
