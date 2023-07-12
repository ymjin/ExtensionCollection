//
//  ExtensionUITextView.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation
extension UITextView {
    /// 여백 지정
    /// - Parameter inset: 여백 지정 값
    public func inset(inset: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)) {
        textContainerInset = inset
    }
}
