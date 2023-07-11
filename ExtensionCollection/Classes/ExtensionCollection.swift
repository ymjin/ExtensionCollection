import Foundation
import UIKit

@available(iOS 11.0, *)
extension UIDevice {
    /// 노치 여부 판단
    public var isNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

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

extension String {
    /// 이미지 생성
    /// - Returns: 생성된 이미지
    public func toImage() -> UIImage {
        return UIImage(named: self)!
    }

    /// 이메일 정규식 판단
    /// - Returns: 정규식 적합 여부
    public func regCheckEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// 폰번호 정규식 판단
    /// - Returns: 정규식 적합 여부
    public func regCheckPhoneNumber() -> Bool {
        let pattern = "^[0-9]{11}$"
        let result = self.range(of: pattern, options: .regularExpression ) != nil
        return result
    }
    
    /// 차량번호 정규식 판단
    /// - Parameter business: 영업용 / 개인용
    /// - Returns: 정규식 적합 여부
    public func regCheckCarNumber(business:Bool = true) -> Bool {
        if business {
            if regCheckCarNumber01() {
                return true
            }
            else {
                return regCheckCarNumber02()
            }
        }
        else {
            return regCheckCarNumber03()
        }
    }

    /// 영업용 (구)차량번호 정규식 판단
    /// - Returns: 정규식 적합 여부
    func regCheckCarNumber01() -> Bool {
        let pattern = "^[서울|부산|대구|인천|대전|광주|울산|제주|경기|강원|충남|전남|전북|경남|경북|세종]{2}(8([0-7])|9(8|9))[아바사자]\\d{4}$"
        let result = self.range(of: pattern, options: .regularExpression ) != nil
        return result
    }
    
    /// 영업용 (신)차량번호 정규식 판단
    /// - Returns: 정규식 적합 여부
    func regCheckCarNumber02() -> Bool {
        let pattern = "^\\d{3}[아바사자]\\d{4}$"
        let result = self.range(of: pattern, options: .regularExpression ) != nil
        return result
    }

    /// 개인용 차량번호 정규식 판단
    /// - Returns: 정규식 적합 여부
    func regCheckCarNumber03() -> Bool {
        let pattern = "^\\d{2,3}[가-힣]{1}\\d{4}$"
        let result = self.range(of: pattern, options: .regularExpression ) != nil
        return result
    }
}

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

extension Int {
    /// ms to day
    public var day: Int {
        self / 86400
    }
    
    /// ms to Hour
    public var hour: Int {
        self / 3600
    }
    
    /// ms to minute
    public var minute: Int {
        (self % 3600) / 60
    }
    
    /// ms to second
    public var seconds: Int {
        (self % 60)
    }
}
