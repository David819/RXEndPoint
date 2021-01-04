//
//  APIService.swift
//  EndPointRX
//
//  Created by Rachel on 2020/12/31.
//

import Foundation
import RxSwift
import RxCocoa

let token = "442174a35859dde22566bb856d1d4935353a08e7"
let urlStr = "https://api.github.com/users/defunkt?access_token="

extension TimeInterval {
    func toDateString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yy-MM-dd HH:mm:ss"
        return df.string(from: Date(timeIntervalSince1970: self))
    }
}

// MARK: - PROTOCOLS

protocol Endpointable {
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
}

extension Endpointable {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL.")
        }
        return url
    }
    
    var request: URLRequest {
        URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
    }
}

// MARK: - STRUCTS

struct UserEndpoint: Endpointable {
    var path: String
    var queryItems: [URLQueryItem]
}
    
extension UserEndpoint {
    static func getUsers(name: String) -> Self {
        UserEndpoint(path: "users/\(name)", queryItems: [URLQueryItem(name: "access_token", value: token)])
    }
}


