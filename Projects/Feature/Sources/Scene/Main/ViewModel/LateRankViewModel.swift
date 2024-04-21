import Foundation
import Moya
import Service

struct LateRankData {
    let id: UUID
    let profileImageURL: String?
    let name: String
    let grade: Int
    let major: String
}

public final class LateRankViewModel {
    let lateProvider = MoyaProvider<LateServices>()

    var lateRank: [LateRankResponse] = []
    var lateRankDatas: [LateRankData] = []
    
    let keyChain = KeyChain()
    let gomsRefreshToken = GOMSRefreshToken.shared
    lazy var accessToken = "Bearer " + (keyChain.read(key: Const.KeyChainKey.accessToken) ?? "")
    
    func lateRank(completion: @escaping (Bool) -> Void) {
        lateProvider.request(.lateRank(authorization: accessToken)) { response in
            switch response {
            case .success(let result):
                let responseData = result.data
                do {
                    self.lateRank = try JSONDecoder().decode([LateRankResponse].self, from: responseData)
                } catch (let err) {
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200:
                    print("OK")
                    completion(true)
                case 401:
                    print("만료된 accessToken일 경우 / 유효하지 않은 accessToken일 경우")
                    completion(false)
                case 404:
                    print("지각자가 없을 경우")
                    completion(false)
                case 500:
                    print("SERVER ERROR")
                    completion(false)
                default:
                    print(result)
                    completion(false)
                }

            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
}
