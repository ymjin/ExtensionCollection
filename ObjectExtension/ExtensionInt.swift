//
//  ExtensionInt.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension Int {
    /// ms to day
    public var day: Int {
        self / 86400
    }
    
    /// ms to Hour
    public var hour: Int {
        self / 3600
    }
    
    /// ms to minute
    public var minute: Int {
        (self % 3600) / 60
    }
    
    /// ms to second
    public var seconds: Int {
        (self % 60)
    }
}
