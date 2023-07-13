//
//  ExtensionNSMutableAttributedString.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

extension NSMutableAttributedString {
    /// 특정 문자 weight 변경
    /// - Parameters:
    ///   - weight: 문자 스타일 지정, 기본 볼드
    ///   - changeString: 스타일 변경 처리할 문자
    ///   - fontSize: 스타일 변경할  문자 폰트 사이즈
    /// - Returns: 수정된 문자
    public func changeWeight(weight:UIFont.Weight = .bold, changeString: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let range = (string as NSString).range(of: changeString)
        self.addAttributes(attributes, range: range)
        
        return self
    }
    
    /// 특정 문자 색상 변경
    /// - Parameters:
    ///   - colorString: 색상 변경할 문자
    ///   - color: 변경할 색상
    /// - Returns: 수정된 문자
    public func changeColor(colorString: String, color:UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        let range = (string as NSString).range(of: colorString)
        self.addAttributes(attributes, range: range)
        
        return self
    }
    
    /// 특정 문자 사이즈 변경
    /// - Parameters:
    ///   - fontName: 폰트 이름 지정
    ///   - sizeString: 사이즈 변경할 문자
    ///   - fontSize: 변경할 폰트 사이즈
    ///   - offset: 사이즈 변경으로 인한 위치 조정 수치
    ///   - weight: 문자 스타일 지정
    /// - Returns: 수정된 문자
    public func changeSize(fontName:String = "", sizeString: String, fontSize: CGFloat, offset:CGFloat = 0, weight:UIFont.Weight = .regular) -> NSMutableAttributedString {
        let font = fontName == "" ? UIFont.systemFont(ofSize: fontSize, weight: weight) : UIFont(name: fontName, size: fontSize)!
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let range = (string as NSString).range(of: sizeString)
        self.addAttributes(attributes, range: range)
        self.addAttribute(.baselineOffset, value: offset, range: range)
        
        return self
    }
    
    /// 줄간격 조정
    /// - Parameter space: 줄간격 조정 수치
    /// - Returns: 수정된 문자
    public func lineSpace(space:CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = space
        self.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
        
        return self
    }
    
    /// 문자에 언더라인 넣기
    /// - Parameters:
    ///   - underLineString: 언더라인 넣을 특정 문자
    ///   - color: 언더라인 색상
    /// - Returns: 수정된 문자
    public func underLine(underLineString:String, color:UIColor) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: underLineString)
        
        let attributes = [NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        self.addAttributes(attributes, range: range)
        
        return self
    }
}




