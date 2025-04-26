// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? JSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - UserElement
struct UserElement: Codable {
    let code, az, en, tr: String?
    let ru: String?
}

typealias User11 = [UserElement]
