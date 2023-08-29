//
//  PhotoAPI.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import UIKit
import Alamofire

enum PhotoApiType {
    case getListPhoto
}

struct PhotoApi: API {
    
    var type: PhotoApiType?
    
    var path: APIPath {
        switch type {
        case .getListPhoto:
            return .photo
        default:
            return .undefined
        }
    }
    var headers: HTTPHeaders? {
        var headers = HTTPHeaders()
        headers.addAuthorization()
        switch type {
        case .getListPhoto:
            headers.addAccept()
        default:
            break
        }
        return headers
    }

    var method: HTTPMethod {
        switch type {
        case .getListPhoto:
            return .get
        default:
            return .post
        }
    }
    
    var parameters: Parameters?
    
    init(_ type: PhotoApiType, params: Parameter? = nil) {
        self.type = type
        parameters = params
    }
    
    func send(queue: DispatchQueue = .main,
              decoder: DataDecoder = JSONDecoder(),
              callBack: @escaping ([PhotoViewEntity]?, Error?) -> Void) {
        sendWithToken(of: [PhotoDataEntity].self,
                      queue: queue,
                      decoder: decoder,
                      success: { (model, error) in
            let result = model?.map({PhotoViewEntity(url: $0.downloadURL)})
            callBack(result, error)
        })
    }
}

struct PhotoDataEntity: Codable {
    let id, author, url, downloadURL: String?
    let width, height: Int?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

struct PhotoViewEntity {
    let url: String?
}
