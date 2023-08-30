//
//  Log.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import Foundation

public func DLog(_ message: @autoclosure () -> String,
                 filename: String = #file,
                 function: String = #function, line: Int = #line) {
    #if DEV
    print("[\(URL(string: filename)?.lastPathComponent ?? filename):\(line)]",
        "\(function)",
        message(),
        separator: " - ")
    #else
    #endif
}

public func ALog(_ message: @autoclosure () -> String,
                 filename: String = #file,
                 function: String = #function,
                 line: Int = #line) {
    print("[\(URL(string: filename)?.lastPathComponent ?? filename):\(line)]",
        "\(function)",
        message(),
        separator: " - ")
}
