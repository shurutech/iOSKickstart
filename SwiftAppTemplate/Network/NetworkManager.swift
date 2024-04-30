//
//  NetworkManager.swift
//  SwiftAppTemplate
//
//  Created by Ashok Choudhary on 03/01/24.
//
import Alamofire
import Foundation

struct ErrorResponse: Codable {
    let detail: String
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }

    // MARK: - Attributes
    
    private let session: Session = .default
    
    
    // MARK: - Requests
    
    func request<T:Decodable>(_ api: APIEndpoints, type: T.Type) async throws -> T {
        let data = try await request(api)
        
        do {
            let decoder = JSONDecoder()            
            return try decoder.decode(T.self, from: data)
        }
        catch {
            ErrorHandler.logError(message: "Decoding error (\(api.data.0), \(api.data.1))", error: error)
            throw AppError.decodingError(error)
        }
    }
    
    @discardableResult
    func request(_ api: APIEndpoints) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            request(api) { result in
                if case .failure(let error) = result {
                    ErrorHandler.logError(message: "Request failed (\(api.data.0), \(api.data.1))", error: error)
                }
                
                continuation.resume(with: result)
            }
        }
    }
    
    func request(_ api: APIEndpoints, completion: @escaping (Result<Data, AppError>) -> Void) {
        guard let authToken = KeyChainStorage.shared.getAuthToken() else {
            completion(.failure(AppError.failedToLoadToken))
            return
        }

        // url
        let baseURL = AppConfig.BASE_URL.absoluteString
        let url = baseURL + api.data.1
        
        // parameters
        var parameters: [String:String] = [:]
        
        for (key, value) in api.urlParameters {
            if let value = value?.nilIfEmpty {
                parameters[key] = value
            }
        }

        var urlComponents = URLComponents(string: url)!

        // construct full url
        if(!parameters.isEmpty){
            let queryItems = parameters.map  { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.queryItems = queryItems
        }

        // headers
        var headers: HTTPHeaders = [:]
        headers.add(name: "Authorization", value: "Bearer \(authToken)")
                
        session.request(urlComponents, method: api.data.0, parameters: getParamsEncoded(params: api.parameters), encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    self.handleFailure(error: error, response: response, completion: completion)
                }
            }
        #if DEBUG
            .cURLDescription { print("---\n\($0)\n---") }
        #endif
    }
    
    
    // MARK: - Helpers

    private func handleFailure(error: Error, response: AFDataResponse<Data>, completion: @escaping (Result<Data, AppError>) -> Void) {
        if let httpResponse = response.response, httpResponse.statusCode == 401 {
            self.handleUnauthorizedAccessError()
            completion(.failure(AppError.unauthorizedAccess))
        }
        else if let data = response.data {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                let errorMessage = errorResponse.detail
                completion(.failure(.serverError(errorMessage)))
            } catch {
                completion(.failure(.networkError(error)))
            }
        }
        else {
            completion(.failure(.networkError(error)))
        }
    }
    
    private func handleUnauthorizedAccessError() {
        Task { @MainActor in
            try await AuthenticationManager.shared.logout()
        }
    }


    private func getParamsEncoded(params: Encodable?) -> Parameters? {
        guard let params = params else { return nil }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try! encoder.encode(params)
        let encodedParams = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters
        return encodedParams
    }
    
}
