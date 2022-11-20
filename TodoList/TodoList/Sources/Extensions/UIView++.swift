//
//  UIView++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import SwiftUI
import UIKit

extension UIView {
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(view: self)
    }
}
