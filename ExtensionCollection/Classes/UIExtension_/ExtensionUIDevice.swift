//
//  ExtensionUIDevice.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

@available(iOS 11.0, *)
extension UIDevice {
    /// 노치 여부 판단
    public var isNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
