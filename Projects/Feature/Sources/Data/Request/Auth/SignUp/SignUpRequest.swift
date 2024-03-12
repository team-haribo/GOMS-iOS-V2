import Foundation

struct SignUpRequest: Codable {
    let header: Header
    let body: Body
    
    struct Header: Codable {
        let Authorization: String
    }
    
    struct Body: Codable {
        let email: String
        let password: String
        let name: String
        let gender: String
        let Major: String
    }
    
    init(header: Header, body: Body) {
        self.header = header
        self.body = body
    }
}
