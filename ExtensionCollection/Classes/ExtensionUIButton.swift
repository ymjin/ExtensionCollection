//
//  ExtensionUIButton.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension UIButton {
    /// 왼쪽 텍스트 오른쪽 이미지 배치
    /// - Parameters:
    ///   - imageRightPadding: 이미지 오른쪽 여백
    ///   - imageLeftPadding: 이미지 왼쪽 여백
    ///   - imageBottomPadding: 이미지 하위 여백
    ///   - titleLeftPadding: 타이틀 왼쪽 여백
    ///   - titleBottomPadding: 타이틀 하위 여백
    ///   - width: 버튼 전체 너비 지정
    public func leftTextRightImage(imageRightPadding: CGFloat = 10, imageLeftPadding: CGFloat = 0, imageBottomPadding:CGFloat = -3, titleLeftPadding:CGFloat = 0, titleBottomPadding:CGFloat = 0, width:CGFloat = 0) {
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        self.contentHorizontalAlignment = .left
        
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageViewWidth + titleLeftPadding, bottom: titleBottomPadding, right: 0.0)
        if width != 0 {
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: width - imageViewWidth - imageRightPadding, bottom: imageBottomPadding, right: -imageRightPadding)
        }
        else {
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: bounds.width - imageViewWidth - imageRightPadding - titleLeftPadding, bottom: imageBottomPadding, right: -imageRightPadding)
        }
    }
    
    /// 상단 이미지 하단 타이틀
    /// - Parameter space: 이미지와 타이틀 사이 여백
    public func alignTextBelow(space: CGFloat = 8.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])

        titleEdgeInsets = UIEdgeInsets(top: space, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + space), left: 0, bottom: 0, right: -titleSize.width)
    }
}
