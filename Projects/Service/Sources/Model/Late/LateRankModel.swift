import Foundation

public struct LateRankModel: Codable {
    let data: OutingListResponse
}

public struct LateRankResponse: Codable {
    public let accountIdx: UUID
    public let name: String
    public let major: String
    public let grade: Int
    public let gender: String
    public let profileUrl: String?
}
