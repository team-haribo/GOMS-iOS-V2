import Foundation
import Moya

public enum LateServices {
    case lateRank(authorization: String)
}

extension LateServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .lateRank:
            return "/late/rank"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .lateRank:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .lateRank:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .lateRank(let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
