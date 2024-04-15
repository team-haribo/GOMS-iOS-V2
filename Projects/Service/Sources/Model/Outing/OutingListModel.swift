import Foundation

public struct OutingListModel: Codable {
    let data: OutingListResponse
}

public struct OutingListResponse: Codable {
    let accountIdx: UUID
    let name: String
    let major: String
    let grade: Int
    let gender: String
    let profileUrl: String?
    let createdTime: String
}
