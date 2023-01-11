//
//  APIRequest.swift
//
//
//  Created by Kevin Hinkson on 2023-01-05.
//  This is originally from AWS Lambda Runtime and modified to suit
//  https://github.com/swift-server/swift-aws-lambda-runtime
//

import Foundation
import AWSLambdaEvents

/// APIGateway.V2.Request contains data coming from the new HTTP API Gateway
public struct APIRequest: Codable {
    
    /// Context contains the information to identify the AWS account and resources invoking the Lambda function.
    public struct Context: Codable {
        public struct HTTP: Codable {
            public let method: AWSLambdaEvents.HTTPMethod
            public let path: String
            public let `protocol`: String
            public let sourceIp: String
            public let userAgent: String
        }

        public let accountId: String
        public let apiId: String
        public let domainName: String
        public let domainPrefix: String
        public let stage: String
        public let requestId: String
        public let routeKey: String

        public let http: HTTP

        /// The request time in format: 23/Apr/2020:11:08:18 +0000
        public let time: String
        public let timeEpoch: UInt64
    }

    public let version: String
    public let routeKey: String
    public let rawPath: String
    public let rawQueryString: String

    public let cookies: [String]?
    public let headers: AWSLambdaEvents.HTTPHeaders
    public let queryStringParameters: [String: String]?
    public let pathParameters: [String: String]?
    public let stageVariables: [String: String]?
    
    public let context: Context

    public let body: String?            // This does not exist for lambda authorizer request payload
    public let isBase64Encoded: Bool?

    enum CodingKeys: String, CodingKey {
        case version
        case routeKey
        case rawPath
        case rawQueryString

        case cookies
        case headers
        case queryStringParameters
        case pathParameters

        case context = "requestContext"
        case stageVariables

        case body
        case isBase64Encoded
    }
    
    public struct Authorization {
        
        public struct Response: Codable {
            let isAuthorized    : Bool
            
            public init(isAuthorized: Bool) {
                self.isAuthorized = isAuthorized
            }
        }
    }
    
    public func body<T: Decodable>(type: T.Type, userInfo: [CodingUserInfoKey: Any] = [:]) throws -> T? {
        guard var content: String = body else {
            return nil
        }
        
        if content.isEmpty {
            return nil
        }
        
        if true == isBase64Encoded {
            guard let converted: String = .init(base64Encoded: content) else {
                throw APIRequestError.invalidBase64EncodedContent(.init(), content)
            }
            content = converted
        }
        return try JSONDecoder.jsonAPI(userInfo: userInfo).decode(T.self, from: content)
    }
    
    /**
     * Throws an error if the specified content type does not match
     */
    public func validateContentType(contentType: ContentType) throws {
        guard let (_, value) = headers.first(where: {$0.key.lowercased() == ContentType.contentTypeHeaderKey()}) else {
            throw APIRequestError.missingContentType(.init())
        }
        let expectedContentType: String = (contentType == .json_api) ? ContentType.jsonAPIContentHeaderValue() : ContentType.jsonContentHeaderValue()
        guard value.lowercased() == expectedContentType else {
            throw APIRequestError.invalidContentType(.init(), value.lowercased())
        }
    }
}
