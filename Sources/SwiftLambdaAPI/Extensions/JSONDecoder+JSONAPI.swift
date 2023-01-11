//
//  JSONDecoder+JSONAPI.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation

extension JSONDecoder {
    public static func jsonAPI(userInfo: [CodingUserInfoKey: Any] = [:]) -> JSONDecoder {
        let jsonDecoder: JSONDecoder = .init()
        jsonDecoder.userInfo = userInfo
        jsonDecoder.dateDecodingStrategy = .custom( {(decoder) in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            guard let date = dateString.iso8601withFractionalSeconds else {
                throw DecodingError.typeMismatch(
                    Date.Type.self,
                    DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription: "Decoding date failed for \(dateString)")
                )
            }
            return date
        })
        return jsonDecoder
    }
}
