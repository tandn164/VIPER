//
//  AppConfig.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import Foundation

struct AppConfig {
    public static var baseUrl: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "base_url") as? String else {
            fatalError()
        }
        return baseUrl
    }
}
