import Foundation
import Moya

enum AuthServices {
    case signUp(param: SignUpRequest)
    case signIn(param: SignInRequest)
    case refreshToken(refreshToken: String)
    case emailSend(param: EmailSendRequest)
    case emailVerify(param: EmailVerifyRequest)
}


extension AuthServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return"/api/v2/auth/signup/"
        case .signIn:
            return "/api/v2/auth/signin/"
        case .refreshToken:
            return "/api/v2/auth/"
        case .emailSend:
            return "/api/v2/auth/email/send/"
        case .emailVerify:
            return "/api/v2/auth/email/verify/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .signIn:
            return .post
        case .refreshToken:
            return .patch
        case .emailSend:
            return .post
        case .emailVerify:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        case .signIn(let param):
            return .requestJSONEncodable(param)
        case .refreshToken:
            return .requestPlain
        case .emailSend(let param):
            return .requestJSONEncodable(param)
        case .emailVerify(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refreshToken(let refreshToken):
            return["Content-Type" :"application/json", "refreshToken" : refreshToken]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
