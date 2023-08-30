//
//  API.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import Foundation
import UIKit
import Alamofire

public typealias Parameter = Parameters
public typealias DataUpLoad = (data: Data, name: String, fileName: String, mimeType: String)

struct HeaderKey {
    static let Accept              = "Accept"
    static let ContentType         = "Content-Type"
    static let Authorization       = "Authorization"
}

struct HeaderValue {
    static let applicationJson = "application/json"
}

enum APIPath: String {
    case undefined = ""
    case photo = "/list"
}

protocol API {
    var path: APIPath { get }
    var parameters: Parameters? { get }
    var expandPath: String? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension API {
    var path: APIPath { .undefined }
    var parameters: Parameters? { nil }
    var expandPath: String? { nil }
    var method: HTTPMethod { .get }
    var headers: HTTPHeaders? { nil }
}

extension API {
    func send<T: Decodable>(of type: T.Type = T.self,
                            queue: DispatchQueue = .main,
                            decoder: DataDecoder = JSONDecoder(),
                            completion: @escaping (T?, Error?) -> Void) {

        let url = "\(AppConfig.baseUrl)\(path.rawValue)\(expandPath ?? "")"
        DLog("URL: \(url)")
        let request = AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 headers: headers)
        request.responseDecodable(of: T.self) { (response) in
            DLog("RESPONSE: \(response.description)")
            
            switch response.result {
            case let .success(data):
                completion(data, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    
    func sendWithToken<T: Decodable>(of type: T.Type = T.self,
                                     queue: DispatchQueue = .main,
                                     decoder: DataDecoder = JSONDecoder(),
                                     success: @escaping (T?, Error?) -> Void) {

        let url = "\(AppConfig.baseUrl)\(path.rawValue)\(expandPath ?? "")"
        DLog("URL: \(url)")
        print(777, url)
        let request = AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 headers: headers)
        request.responseDecodable(of: T.self) { (response) in
            DLog("RESPONSE: \(response.description)")
            
            switch response.result {
            case let .success(data):
                success(data,nil)
            case let .failure(error):
                success(nil,error)
            }
        }
    }
}

extension Parameter {
    mutating func addParam(_ key: String, value: Value?) {
        if let valueObj = value {
            updateValue(valueObj, forKey: key)
        }
    }
}

extension HTTPHeaders {
    
    mutating func addAccept() {
        add(name: HeaderKey.Accept, value: HeaderValue.applicationJson)
    }
    
    mutating func addAuthorization() {
        let value = "Bearer"
        add(name: HeaderKey.Authorization, value: value)
    }
    
    mutating func addContentType() {
        add(name: HeaderKey.ContentType, value: HeaderValue.applicationJson)
    }
}
