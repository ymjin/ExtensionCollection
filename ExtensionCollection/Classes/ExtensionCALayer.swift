//
//  ExtensionCALayer.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/13.
//

import Foundation

extension CALayer {
    /// 보더 라인 그리기
    /// - Parameters:
    ///   - width: 너비
    ///   - radius: 반경
    ///   - color: 색상
    func changeBorder(width: CGFloat = 1, radius: CGFloat = 10, color: UIColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1)) {
        cornerRadius = radius
        borderWidth = width
        borderColor = color.cgColor
    }
}
