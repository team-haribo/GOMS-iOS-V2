import Foundation
import Moya

public enum ProfileServices {
    case getProfile(authorization: String)
}

extension ProfileServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2/account/")!
    }
    
    public var path: String {
        switch self {
        case .getProfile:
            return "profile"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProfile:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getProfile:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getProfile(let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        }
    }
}
