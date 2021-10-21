//
//  APIRouter.swift
//  camlist
//
//  Created by mohamed salah on 9/2/21.
//

import Foundation
import Alamofire


protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://api.foursquare.com/v2"
        static let clientId  = "NTNX141WCRIVGWEPPOR3IPQXJ4YI1PWCCOYUCZXDIHQMXM5P"
        static let clientSecret = "3XEEIV5VA4GV5XTWR5PQA5ZGTRRBHPFPSWBEQW53CMXRQWK4"
        static let version = "20120609"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    
}

enum ContentType: String {
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}


enum APIRouter: APIConfiguration {
    
    case getPlaces(lat: String, lang: String)

    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getPlaces:
            return .get
        }
    }
    // MARK: - Parameters
    var parameters: RequestParams {
        switch self {
       
        case .getPlaces(let lat,let lang):
            return .url(["ll":"\(lat),\(lang)",
                         "client_id":Constants.ProductionServer.clientId ,
                         "client_secret": Constants.ProductionServer.clientSecret,
                         "v": Constants.ProductionServer.version ])
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getPlaces:
            return "/venues/explore"
       
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Parameters
        switch parameters {
        
        case .body(let params):
            
            urlRequest.httpBody =  try! JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}


