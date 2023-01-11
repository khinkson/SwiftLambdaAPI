//
//  File.swift
//  
//
//  Created by Kevin Hinkson on 2023-01-10.
//

import Foundation

extension Date {
    public var iso8601withFractionalSeconds: String {
        return Formatter.iso8601withFractionalSeconds.string(from: self)
    }
}
