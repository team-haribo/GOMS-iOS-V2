import Foundation

struct SignUpModel: Codable {
    let data: SignUpResponse
}

struct SignUpResponse: Codable {
    let email: String
    let password: String
    let name: String
    let gender: String
    let Major: String
}
