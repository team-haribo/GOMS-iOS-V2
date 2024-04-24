import Foundation
import Moya

public enum StudentCouncilServices {
    case makeQRCode(authorization: String)
    case deleteOuting(authorization: String, accountIdx: UUID)
}

extension StudentCouncilServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .makeQRCode:
            return "/student-council/outing"
        case .deleteOuting(_ , let accountIdx):
            return "/student-council/outing/\(accountIdx)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .makeQRCode:
            return .post
        case .deleteOuting:
            return .delete
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .makeQRCode:
            return .requestPlain
        case .deleteOuting:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case let .makeQRCode(authorization):
            return ["Content-Type" :"application/json", "Authorization" : authorization]
        case .deleteOuting(let authorization, _):
            return ["Content-Type" :"application/json", "Authorization" : authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
