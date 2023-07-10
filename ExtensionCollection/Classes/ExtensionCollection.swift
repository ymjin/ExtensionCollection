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
        
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// 각 모서리 라운드 처리
    /// - Parameters:
    ///   - cornerRadius: 반경
    ///   - maskedCorners: 라운드 처리할 모서리 지정
    ///   - width: 너비
    ///   - color: 색상
    public func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask, width:CGFloat = 1, color: UIColor = UIColor.clear) {
        clipsToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        layer.borderColor = color.cgColor
        layer.borderWidth = width
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
