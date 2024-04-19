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
//            switch self {
//            default:
//                return ["Content-Type": "application/json"]
//            }
        ["authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJhY2Nlc3MiLCJhdXRob3JpdHkiOiJST0xFX1NUVURFTlRfQ09VTkNJTCIsImlhdCI6MTcxMzQ1Mzc3MCwiZXhwIjoxNzEzNDY0NTcwfQ.FgLrHa0xQ3PZZQjP_J6VWwiTaTH4e5cpeQS5vuf4xQU"]
        }
}
