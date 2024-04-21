import Foundation

public struct LateRankRequest: Codable {
    let Authorization: String
    
    public init(Authorization: String) {
        self.Authorization = Authorization
    }
}
