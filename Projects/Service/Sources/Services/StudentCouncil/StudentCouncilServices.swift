import Foundation
import Moya

public enum StudentCouncilServices {
    case makeQRCode(authorization: String)
    case deleteOuting(authorization: String, accountIdx: UUID)
    case studentList(authorization: String)
    case editAuthority(authorization: String, param: AuthorityRequest)
    
    case changeBlackList(authorization: String, accountIdx: UUID)
    case cancelBlackList(authorization: String, accountIdx: UUID)
    case searchStudent(authorization: String, parm: SearchStudentRequest)
}

extension StudentCouncilServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-goms-backend-v2-duzu222alg58k27h.sel3.cloudtype.app/api/v2")!
    }
    
    public var path: String {
        switch self {
        case .makeQRCode:
            return "/student-council/outing"
        case .deleteOuting(_ , let accountIdx):
            return "/student-council/outing/\(accountIdx)"
        case .studentList:
            return "/student-council/accounts"
        case .editAuthority:
            return "/student-council/authority"
        case .changeBlackList(_, let accountIdx):
            return "/student-council/black-list/\(accountIdx)"
        case .cancelBlackList(_ , let accountIdx):
            return "/student-council/black-list/\(accountIdx)"
        case .searchStudent:
            return "/student-council/search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .makeQRCode,
             .changeBlackList:
            return .post
        case .deleteOuting,
             .cancelBlackList:
            return .delete
        case .studentList,
             .searchStudent:
            return .get
        case .editAuthority:
            return .patch
        }
    }
    
    public var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .makeQRCode,
             .deleteOuting,
             .studentList,
             .changeBlackList,
             .cancelBlackList:
            return .requestPlain
        case .editAuthority(_, let param):
            return .requestJSONEncodable(param)
        case .searchStudent(_, let param):
            return .requestParameters(parameters: ["grade": param.grade ?? 0, "gender": param.gender ?? "", "name": param.name ?? "", "isBlackList": param.isBlackList, "authority": param.authority ?? ""], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .makeQRCode(let authorization),
             .studentList(let authorization):
            return ["Content-Type" :"application/json", "Authorization" : authorization]
        case .deleteOuting(let authorization, _),
             .editAuthority(let authorization, _),
             .changeBlackList(let authorization, _),
             .cancelBlackList(let authorization, _),
             .searchStudent(let authorization, _):
            return ["Content-Type" :"application/json", "Authorization" : authorization]
        }
    }
}
