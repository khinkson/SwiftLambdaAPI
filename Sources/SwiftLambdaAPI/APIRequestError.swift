//
//  RequestError.swift
//
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation

public enum APIRequestError: LocalizedError {
    case invalidContentType(UUID, String)
    case missingContentType(UUID)
    case invalidBase64EncodedContent(UUID, String)
    
    public var errorDescription: String? {
        switch self {
            
        case .invalidBase64EncodedContent(_, let content):
            return "Invalid Base64 Encoded Body|content:\(content)"
            
        case .invalidContentType(_, let header):
            return "Invalid content type header|content-type:\(header)"
            
        case .missingContentType(_):
            return "Missing content type header"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case
                .invalidBase64EncodedContent(let errorID, _),
                .invalidContentType(let errorID, _),
                .missingContentType(let errorID):
            return errorID.uuidString
        }
    }
}
