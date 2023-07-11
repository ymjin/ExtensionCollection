//
//  UIExtension.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/11.
//

import Foundation
import UIKit

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

extension UILabel {
    /// 필요한 높이 계산
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// 필요한 너비 계산
    public var requiredWidth: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }
}

extension UITextField {
    /// 왼쪽 여백 주기
    /// - Parameter width: 여백 너비
    public func addLeftPadding(width:CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    /// placeHolder 글자 색상 변경
    /// - Parameter color: 색상
    public func setPlaceHolderTextColor(color:UIColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 0.28)) {
        if placeholder != nil {
            attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        }
    }
    
    /// 입력된 글자 삭제 버튼 설정
    /// - Parameters:
    ///   - frame: 버튼 크기
    ///   - image: normal Image
    ///   - hImage: highlighted Image
    ///   - mode: UITextField.ViewMode
    public func addClearButton(with frame:CGRect = CGRect(x: 0, y: 0, width: 40, height: 40), image: UIImage, hImage:UIImage, mode: UITextField.ViewMode) {
        let buttonView = UIView(frame: frame)
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.setImage(hImage, for: .highlighted)
        clearButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .touchUpInside)
        
        buttonView.addSubview(clearButton)
        
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingChanged)
        self.rightView = buttonView
        self.rightViewMode = mode
    }
    
    /*
     @description
     - 글자가 입력되면 삭제 버튼 표시
     @param nil
     @return nil
     */
    @objc
    private func displayClearButtonIfNeeded() {
        self.rightView?.isHidden = (self.text?.isEmpty) ?? true
    }
    
    /*
     @description
     - 삭제 버튼 클릭시 입력된 글자 지우기
     @param sender 이벤트 객체
     @return nil
     */
    @objc
    private func clear(sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

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

extension UITextView {
    /// 여백 지정
    /// - Parameter inset: 여백 지정 값
    public func inset(inset: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)) {
        textContainerInset = inset
    }
}

extension UIImageView {
    /// url 이미지 다운로드
    /// - Parameter url: 이미지 주소
    public func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

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
