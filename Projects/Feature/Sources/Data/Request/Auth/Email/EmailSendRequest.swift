import Foundation

struct EmailSendRequest: Codable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}
