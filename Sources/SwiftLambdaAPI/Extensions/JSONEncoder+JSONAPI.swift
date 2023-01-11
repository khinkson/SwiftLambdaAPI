//
//  JSONEncoder+JSONAPI.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-10.
//

import Foundation

extension JSONEncoder {
    public static func jsonAPI(userInfo: [CodingUserInfoKey: Any] = [:]) -> JSONEncoder {
        let jsonEncoder: JSONEncoder = .init()
        jsonEncoder.userInfo = userInfo
        jsonEncoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        jsonEncoder.keyEncodingStrategy = .useDefaultKeys
        jsonEncoder.dateEncodingStrategy = .custom( { (date, encoder) in
            let dateString: String = date.iso8601withFractionalSeconds
            var container = encoder.singleValueContainer()
            try container.encode(dateString)
        })
        return jsonEncoder
    }
}
