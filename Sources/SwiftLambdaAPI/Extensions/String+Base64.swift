//
//  String+Base64.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation

extension String {
 
    /**
     * If you have never seen init? before, it simply means that the init returns an Optional
     * If it is not possible to initialize the object, then expect a nil
     * - returns String?
     */
    public init?(base64Encoded: String, encoding: String.Encoding = .utf8) {
        guard let dataValue: Data = .init(base64Encoded: base64Encoded) else {
            return nil
        }
        guard let decodedStringValue: String = .init(data: dataValue, encoding: encoding) else {
            return nil
        }
        self.init(decodedStringValue)
    }
}
