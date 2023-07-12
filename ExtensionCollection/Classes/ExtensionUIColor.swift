//
//  File.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension UIColor {
    /// 색상으로 이미지 생성
    /// - Returns: 생성된 이미지
    public func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
