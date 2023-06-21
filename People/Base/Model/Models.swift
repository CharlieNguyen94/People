import Foundation

// MARK: - DataClass
struct User: Codable, Identifiable {
	let id: Int
	let email, firstName, lastName: String
	let avatar: String
}

// MARK: - Support
struct Support: Codable {
	let url: String
	let text: String
}
