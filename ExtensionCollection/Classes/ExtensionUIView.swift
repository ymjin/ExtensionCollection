//
//  ExtensionUIView.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

@available(iOS 11.0, *)
extension UIView {
    /// View Border 그리기
    /// - Parameters:
    ///   - width: 너비
    ///   - radius: 반경
    ///   - color: 라인 색상
    public func changeBorder(width: CGFloat = 1, radius: CGFloat = 0, color: UIColor = UIColor.clear) {
        clipsToBounds = true
        layer.changeBorder(width: width, radius: radius, color: color)
    }
    
    /// 각 모서리 라운드 처리
    /// - Parameters:
    ///   - maskedCorners: 라운드 처리할 모서리 지정
    ///   - radius: 반경
    ///   - width: 너비
    ///   - color: 색상
    public func roundCorners(maskedCorners: CACornerMask, radius: CGFloat, width:CGFloat = 1, color: UIColor = UIColor.clear) {
        clipsToBounds = true
        
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        layer.changeBorder(width: width, radius: radius, color: color)
    }
}
