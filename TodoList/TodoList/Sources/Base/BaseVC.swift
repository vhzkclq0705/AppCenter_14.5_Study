//
//  BaseVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        configureViewController()
        configureNavigationBar()
        addViews()
        configureLayout()
    }
    
    // MARK: - Func
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func configureViewController() {
        view.backgroundColor = .white
    }
    
    func configureNavigationBar() {}
    
    func addViews() {}
    
    func configureLayout() {}
    
}
