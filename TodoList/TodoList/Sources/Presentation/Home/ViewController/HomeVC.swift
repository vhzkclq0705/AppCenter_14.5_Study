//
//  HomeVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/10/17.
//

import SnapKit
import SwiftUI
import Then
import UIKit

final class HomeVC: BaseViewController {

    // MARK: - UI
    
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.id)
    }
    
    
    // MARK: - Property
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Func
    
    override func configureNavigationBar() {
        self.navigationItem.title = "TodoList"
        
        let plusItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapPlusButton(_:)))
        self.navigationItem.rightBarButtonItem = plusItem
    }
    

    
    // MARK: - Action
    
    @objc func didTapPlusButton(_ sender: Any) {
        
    }

    
}

extension HomeVC: UITableViewDelegate,
                  UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        return UITableViewCell()
    }
    
}
