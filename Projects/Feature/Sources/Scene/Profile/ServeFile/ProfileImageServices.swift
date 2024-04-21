import Foundation
import Moya

struct ProfileImageResponse: Codable {
    let file: Data
}

enum ProfileImageServices {
    case submit(authorization: String, imageData: Data)
    case update(authorization: String, imageData: Data)
    case delete(authorization: String)
}

extension ProfileImageServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2/account")!
    }

    var path: String {
        switch self {
        case .submit:
            return "/image"
        case .update:
            return "/image"
        case .delete:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .submit:
            return .post
        case .update:
            return .patch
        case .delete:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case let .submit(authorization, imageData),
             let .update(authorization, imageData):
            let formData = MultipartFormData(provider: .data(imageData), name: "File", fileName: "profile_image.jpg", mimeType: "image/jpeg")
            return .uploadMultipart([formData])
        case let .delete(authorization):
            return .requestPlain
        }
    }

    var headers: [String : String]? {
    #warning("밑에 코드는 나중에 로그인토큰 연결을 위해 남겨둠")
            switch self {
            default:
                return ["Content-Type": "application/json"]
            }
//        ["authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlNGZhYjE3NC05ODY1LTQ4ZTctOTNjZi1lMDQyNGJmMDlkOGUiLCJ0b2tlblR5cGUiOiJhY2Nlc3MiLCJhdXRob3JpdHkiOiJST0xFX1NUVURFTlRfQ09VTkNJTCIsImlhdCI6MTcxMzUyNDc5NywiZXhwIjoxNzEzNTM1NTk3fQ.rqoP4RA97w2_cbvi7Ur9kuMuAlcKg7FJUeNQOEsHRko"]
        }
}
