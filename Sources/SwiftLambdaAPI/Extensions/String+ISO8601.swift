//
//  String+ISO8601.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-05.
//

import Foundation

extension String {
    public var iso8601withFractionalSeconds: Date? {
        Formatter.iso8601withFractionalSeconds.date(from: self)
    }
}
