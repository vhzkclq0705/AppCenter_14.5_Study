//
//  UIButton++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/27.
//

import UIKit

extension UIButton {
    
    func applyCustomConfig(_ title: String?) {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.setColor(.button)
        config.baseForegroundColor = .white
        config.title = title
        
        self.clipsToBounds = true
        self.configuration = config
    }
    
}
