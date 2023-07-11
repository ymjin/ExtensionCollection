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
