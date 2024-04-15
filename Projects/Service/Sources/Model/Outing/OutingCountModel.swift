import Foundation

public struct OutingCountModel: Codable {
    let data: OutingCountResponse
}

public struct OutingCountResponse: Codable {
    let outingCount: Int
}
