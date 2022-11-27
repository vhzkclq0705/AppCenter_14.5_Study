//
//  String++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import UIKit

extension String {
    
    func makeStrikeThrough(_ isCompleted: Bool) -> NSMutableAttributedString {
        return isCompleted
        ? NSMutableAttributedString(
            string: self,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.lightGray
            ])
        : NSMutableAttributedString(
            string: self,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.lightGray
            ])
    }
    
}
