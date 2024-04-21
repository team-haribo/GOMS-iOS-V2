import Foundation

public struct OutingCountModel: Codable {
    let data: OutingCountResponse
}

public struct OutingCountResponse: Codable {
    public let outingCount: Int
}
