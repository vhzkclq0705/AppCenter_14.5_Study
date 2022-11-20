//
//  UITextField++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import UIKit

extension UITextField {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
      }
    
}
