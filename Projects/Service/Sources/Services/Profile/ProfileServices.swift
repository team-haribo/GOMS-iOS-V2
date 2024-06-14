import Foundation
import Moya

public enum ProfileServices {
    case getProfile(authorization: String)
    case submit(authorization: String, imageData: Data)
    case update(authorization: String, imageData: Data)
    case delete(authorization: String)
}
struct ProfileImageResponse: Codable {
    let file: Data
}

extension ProfileServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://ec38-210-218-52-13.ngrok-free.app/api/v2/account")!
    }
    
    public var path: String {
        switch self {
        case .getProfile:
            return "/profile"
        case .submit:
            return "/image"
        case .update:
            return "/image"
        case .delete:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProfile:
            return .get
        case .submit:
            return .post
        case .update:
            return .patch
        case .delete:
            return .delete
        }
    }
    
    public var task: Task {
        switch self {
        case .getProfile:
            return .requestPlain
        case let .submit(authorization, imageData),
             let .update(authorization, imageData):
            let formData = MultipartFormData(provider: .data(imageData), name: "File", fileName: "profile_image.jpg", mimeType: "image/jpeg")
            return .uploadMultipart([formData])
        case let .delete(authorization):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getProfile(let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
