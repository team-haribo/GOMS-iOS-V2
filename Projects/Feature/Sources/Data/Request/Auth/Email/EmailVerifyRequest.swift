import Foundation

struct EmailVerifyRequest: Codable {
    let queryString: QueryString
        
    struct QueryString: Codable {
        let email: String
        let authCode: String
    }
        
    init(queryString: QueryString) {
        self.queryString = queryString
    }
}
