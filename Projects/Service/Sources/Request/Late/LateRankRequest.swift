import Foundation

public struct LateRankRequest: Codable {
    var lateCount: Int
    
    public init(lateCount: Int) {
        self.lateCount = lateCount
    }
}
