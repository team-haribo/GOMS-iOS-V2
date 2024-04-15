import Foundation
import Moya

public enum OutingServices {
    case outing(authorization: String, qrCode: String)
    case outingList(authorization: String)
    case outingCount(authorization: String)
    case outingSearch(authorization: String, name: String)
    case outingValidation(authorization: String)
}

extension OutingServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL) ?? URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .outing:
            return "/{outingUUID}"
        case .outingList:
            return "/"
        case .outingCount:
            return "/count"
        case .outingSearch:
            return "/search"
        case .outingValidation:
            return "/validation"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .outing:
            return .post
        case .outingList, .outingCount, .outingSearch, .outingValidation:
            return .get
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .outing, .outingList, .outingCount, .outingValidation:
            return .requestPlain
        case let .outingSearch(_, name):
            return .requestParameters(parameters: ["name" : name ?? ""], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .outing(let authorization, _), .outingList(let authorization), .outingCount(let authorization), .outingSearch(let authorization, _), .outingValidation(let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
