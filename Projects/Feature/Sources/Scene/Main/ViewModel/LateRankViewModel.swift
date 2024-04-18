import Moya
import Service

public final class LateRankViewModel {
    let outingProvider = MoyaProvider<OutingServices>(plugins: [NetworkLoggerPlugin()])
    
    let lateProvider = MoyaProvider<LateServices>(plugins: [NetworkLoggerPlugin()])
    
    let profileProvider = MoyaProvider<AccountServices>(plugins: [NetworkLoggerPlugin()])
    
    var userData: AccountModel?
    
    var lateRank: [LateRankResponse] = []
    
    private var lateCount: Int = 0
    
    func lateRank(completion: @escaping (Bool) -> Void) {
        let param = LateRankRequest.init(lateCount: lateCount)
        lateProvider.request(.lateRank(param: param)) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                do {

                }
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
