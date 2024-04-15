import Foundation

public struct AccountModel: Codable {
    let data: AccountReponse
}

public struct AccountReponse: Codable {
    let name: String
    let grade: Int
    let major: String
    let gender: String
    let authority: String
    let profileUrl: String?
    let lateCount: Int
    let isOuting: Bool
    let isBlackList: Bool
}
