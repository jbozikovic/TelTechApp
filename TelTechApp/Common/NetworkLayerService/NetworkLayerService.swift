//
//  NetworkLayerService.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit
import Combine

//  MARK: - NetworkLayerServiceKeys
struct NetworkLayerServiceKeys {
    private init() {}
    
    static let httpHeaderAccept = "Accept"
    static let httpHeaderContentType = "Content-Type"
    static let httpHeaderApplicationJSON = "application/json"
    static let httpHeaderFormUrlencoded = "application/x-www-form-urlencoded"
    static let httpHeaderAuthorization = "Authorization"
    static let httpHeaderApplicationImage = "image/png"
    static let httpHeaderAccessToken = "access-token"
    static let httpHeaderClient = "client"
    static let httpHeaderTokenType = "token-type"
    static let httpHeaderExpiry = "expiry"
    static let httpHeaderUid = "uid"
}


//  MARK: - NetworkLayerProtocol
protocol NetworkLayerProtocol {
    var timeout: TimeInterval { get }
    func executeNetworkRequest<T: Codable>(request: HTTPRequest) -> AnyPublisher<NetworkResponse<T>, Error>
}


//  MARK: - NetworkLayerService
class NetworkLayerService: NSObject, NetworkLayerProtocol {
    var timeout: TimeInterval
    private var cancellables = Set<AnyCancellable>()
    
    /** Default timeout value (10 seconds) fetched from Constants.
    @author Jurica Bozikovic
    */
    init(timeout: TimeInterval = Constants.networkTimeout) {
        self.timeout = timeout
    }
    
    func executeNetworkRequest<T: Codable>(request: HTTPRequest) -> AnyPublisher<NetworkResponse<T>, Error> {
        let url = getFullUrl(url: request.url)
        Utility.printIfDebug(string: "Fetching URL: \(url)")
        guard let urlRequest = createURLRequest(urlString: url,
                                                httpMethod: request.method,
                                                headers: request.headers,
                                                body: request.params) else {
            Utility.printIfDebug(string: "Failed creating URL REQUEST")
            return Fail(error: AppError.genericError).eraseToAnyPublisher()
        }
        let session: URLSession = self.urlSession()
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { result -> NetworkResponse<T> in
                guard self.isSuccessCode(result.response) else {                    
                    Utility.printIfDebug(string: "ERROR occured fetching data: \(result.response)")
                    throw AppError.fetchDataError
                }
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return NetworkResponse(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


//  MARK: - URLSession, URLSessionConfiguration
private extension NetworkLayerService {
    func urlSession() -> URLSession {
        let configuration: URLSessionConfiguration = urlSessionConfiguration()
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    func urlSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = self.timeout
        return configuration
    }
    
    func createURLRequest(urlString: String, httpMethod: HTTPMethod, headers: [HTTPHeader]?, body: [String: Any]?) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        let headers = headers ?? defaultHttpHeader()
        self.appendHttpHeadersToURLRequest(urlRequest: &urlRequest, headers: headers)
        if let httpBody = body, let jsonData = try? JSONSerialization.data(withJSONObject: httpBody) {
            urlRequest.httpBody = jsonData
        }
        return urlRequest
    }
    
    func appendHttpHeadersToURLRequest(urlRequest: inout URLRequest, headers: [HTTPHeader]) {
        headers.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.headerField)
        }
    }
}


//  MARK: - Private methods (isAuthorized, fullUrl, httpHeader)
private extension NetworkLayerService {
    func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return (200...299).contains(urlResponse.statusCode)
    }
    
    func isAuthorized(statusCode: Int?) -> Bool {
        guard let code = statusCode, code == HTTPCode.notAuthorized.rawValue else {
            return true
        }
        return false
    }
    
    func getFullUrl(url: String) -> String {
        return AppUrls.baseUrl + url
    }
    
    func defaultHttpHeader() -> [HTTPHeader] {
        let headers: [HTTPHeader] = [
            HTTPHeader(value: NetworkLayerServiceKeys.httpHeaderApplicationJSON, headerField: NetworkLayerServiceKeys.httpHeaderContentType),
            HTTPHeader(value: NetworkLayerServiceKeys.httpHeaderApplicationJSON, headerField: NetworkLayerServiceKeys.httpHeaderAccept)            
        ]
        return headers
    }
}

//  MARK: - URLSessionDelegate, URLSessionDataDelegate
extension NetworkLayerService: URLSessionDelegate, URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {}

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {}
}

