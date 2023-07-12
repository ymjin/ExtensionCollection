//
//  ExtensionDate.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension Date {
    /// 기준 시간을 한국시간으로 변경
    /// - Returns: Date
    public func UTCToKST() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return self
    }

    /// 년/월/일을 객체로 반환
    /// - Parameters:
    ///   - components: 타입
    ///   - calendar: 캘린더 객체
    /// - Returns: 객체 반환
    public func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    /// 년/월/일을 숫자로 반환
    /// - Parameters:
    ///   - component: 타입
    ///   - calendar: 캘린더 객체
    /// - Returns: 반환 숫자
    public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    /// 시간을 특정 문자열로 반환
    /// - Parameter formatString: 기본 문자열 포맷
    /// - Returns: 시간 문자열
    public func toString(formatString:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let format = formatString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let currentTime = dateFormatter.string(from: self)
        
        return currentTime
    }
}
