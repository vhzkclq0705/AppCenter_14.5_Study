//
//  UIViewController++.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import UIKit
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
