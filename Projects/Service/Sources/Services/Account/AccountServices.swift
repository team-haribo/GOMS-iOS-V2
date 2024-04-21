import Foundation
import Moya

public enum AccountServices {
    case accountProfile
    case accountNewPassword
    case accountImageUpload
    case accountImageChange
    case accountImageDelete
    case newPassword(param: NewPasswordRequest, authorization: String)
}

extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
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
        case .newPassword:
            return "/account/new-password"
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
        case .newPassword:
            return .patch
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .accountProfile, .accountNewPassword, .accountImageUpload, .accountImageChange, .accountImageDelete:
            return .requestPlain
        case .newPassword(let param, _):
            return .requestJSONEncodable(param)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .newPassword(_, let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
