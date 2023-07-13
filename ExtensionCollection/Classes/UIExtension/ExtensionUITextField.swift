//
//  ExtensionUITextField.swift
//  ExtensionCollection
//
//  Created by Youngmin Jin on 2023/07/12.
//

import Foundation

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
