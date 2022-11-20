//
//  String++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import UIKit

extension String {
    
    func makeStrikeThrough(_ isCompleted: Bool) -> NSAttributedString {
        return isCompleted
        ? NSAttributedString(
            string: self,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        : NSAttributedString(string: self)
    }
    
}
