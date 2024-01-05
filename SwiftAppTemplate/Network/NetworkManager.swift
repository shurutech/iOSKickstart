//
//  NetworkManager.swift
//  SwiftAppTemplate
//
//  Created by Ashok Choudhary on 03/01/24.
//

import Foundation
import Alamofire


struct ErrorResponse: Codable {
    let detail: String
}


class NetworkManager {
    static let shared = NetworkManager()
    private init() { }

    // MARK: - Attributes
    
    private let authBaseURL = "base-url"
    private let session: Session = .default
    
    
    // MARK: - Methods
    
    func request(_ api: ApiEndpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        let authToken = "example" //getAuthToken()

        let url = authBaseURL + api.path
        var headers: HTTPHeaders = [:]
        headers.add(name: "Authorization", value: "Bearer \(authToken)")
        
        
        let encoding: ParameterEncoding = (api.method == .get) ? URLEncoding.default : JSONEncoding.default
        
                session.request(url, method: api.method, parameters: api.parameters?.asDictionary(), encoding: encoding, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(String(describing: error))
                    if let httpResponse = response.response, httpResponse.statusCode == 401 {
//                        self.handleUnauthorizedAccessError()
//                        completion(.failure(AppError.unauthorizedAccess))
                    }
                    else if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            let errorMessage = errorResponse.detail
//                            completion(.failure(.serverError(errorMessage)))
                        } catch {
//                            completion(.failure(.networkError(error)))
                        }
                    }
                    else {
//                        completion(.failure(.networkError(error)))
                    }
                }
            }
            .cURLDescription { print("---\n\($0)\n---") }
    }
}


extension Encodable {
    func asDictionary() -> [String: AnyObject]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: AnyObject] }
    }
}
