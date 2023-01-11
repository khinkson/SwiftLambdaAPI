//
//  APIResponse.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation
import AWSLambdaEvents

public struct APIResponse: Codable {
    public var statusCode: HTTPResponseStatus
    public var headers: HTTPHeaders?
    public var body: String?
    public var isBase64Encoded: Bool?
    public var cookies: [String]?

    public init(
        statusCode: HTTPResponseStatus,
        headers: HTTPHeaders? = [:],
        body: String? = nil,
        isBase64Encoded: Bool? = nil,
        cookies: [String]? = nil,
        contentType: ContentType = .json
    ) {
        self.statusCode = statusCode
        self.headers = headers
        let contentTypeHeaders = (contentType == .json_api) ? ContentType.jsonAPIContentHeader() : ContentType.jsonContentHeader()
        self.headers?.merge(contentTypeHeaders, uniquingKeysWith: { (_, new) in new })
        self.body = body
        self.isBase64Encoded = isBase64Encoded
        self.cookies = cookies
    }
}

