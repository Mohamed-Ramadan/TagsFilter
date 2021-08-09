//
//  Constants.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

class Constants {
    static let serverURl = "https://api.stackexchange.com/2.2/questions/no-answers?"
    static let username = "stackexchange"
    static let password = "admin@123456"
    static let contentType = "application/json"
    static let lang = "en"
    static let deviceType = "IOS"
}

enum HTTPMethod: String {
    case get = "GET"
}
