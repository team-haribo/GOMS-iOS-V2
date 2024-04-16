import Foundation

public struct QRCodeRequest: Codable {
    public var outingUUID: UUID
    
    public init(outingUUID: UUID) {
        self.outingUUID = outingUUID
    }
}
