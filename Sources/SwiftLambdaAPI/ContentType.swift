//
//  ContentType.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation

public enum ContentType: String {
    case json_api
    case json
    
    public static func jsonAPIContentHeader() -> [String: String] {
        [contentTypeHeaderKey(): jsonAPIContentHeaderValue()]
    }
    
    public static func jsonContentHeader() -> [String: String] {
        [contentTypeHeaderKey(): jsonContentHeaderValue()]
    }
    
    public static func jsonAPIContentHeaderValue() -> String {
        "application/vnd.api+json"
    }
    
    public static func jsonContentHeaderValue() -> String {
        "application/json"
    }
    
    public static func contentTypeHeaderKey() -> String {
        "content-type"
    }
}
