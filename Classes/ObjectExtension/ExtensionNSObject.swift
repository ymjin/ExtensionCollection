//
//  ExtensionNSObject.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension NSObject {
    /// 클래스 이름
    public var className: String {
        return String(describing: type(of: self))
    }
    
    /// 클래스 이름
    public class var className: String {
        return String(describing: self)
    }
}
