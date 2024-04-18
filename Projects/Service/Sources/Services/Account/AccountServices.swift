import Foundation
import Moya

public enum AccountServices {
    case accountProfile
    case accountNewPassword
    case accountImageUpload
    case accountImageChange
    case accountImageDelete
}

extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL) ?? URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .accountProfile:
            return "/profile"
        case .accountNewPassword:
            return "/new-password"
        case .accountImageUpload, .accountImageChange:
            return "/image"
        case .accountImageDelete:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .accountProfile:
            return .get
        case .accountNewPassword, .accountImageChange:
            return .patch
        case .accountImageUpload:
            return .post
        case .accountImageDelete:
            return .delete
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .accountProfile, .accountNewPassword, .accountImageUpload, .accountImageChange, .accountImageDelete:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
