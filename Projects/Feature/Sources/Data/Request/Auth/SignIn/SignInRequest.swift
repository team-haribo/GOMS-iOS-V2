import Foundation

struct SignInRequest: Codable {
    let header: Header
    let body: Body
    
    struct Header: Codable {
        let Authorization: String
    }
    
    struct Body: Codable {
        let email: String
        let password: String
    }
    
    init(header: Header, body: Body) {
        self.header = header
        self.body = body
    }
}
