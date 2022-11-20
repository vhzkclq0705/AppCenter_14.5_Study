//
//  UIColor++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import UIKit

enum Colors {
    case background
    case button
}

extension UIColor {
    
    static func setColor(_ color: Colors) -> UIColor {
        switch color {
        case .background: return #colorLiteral(red: 0.03137254902, green: 0.03137254902, blue: 0.03137254902, alpha: 1)
        case .button: return #colorLiteral(red: 0.3104107678, green: 0.6914669871, blue: 0.7978377938, alpha: 1)
        }
    }
    
}
