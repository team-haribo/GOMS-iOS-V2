import Foundation
import Moya

public enum StudentCouncilServices {
    case makeQRCode(authorization: String)
}

extension StudentCouncilServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL) ?? URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .makeQRCode:
            return "/student-council/outing"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .makeQRCode:
            return .post
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .makeQRCode:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case let .makeQRCode(authorization):
            return ["Content-Type" :"application/json", "Authorization" : authorization]
        }
    }
}
