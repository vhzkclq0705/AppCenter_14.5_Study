//
//  HomeVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/10/17.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Property
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Func
    
    func configureVC() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    // MARK: - Action

    
}

extension HomeVC: UITableViewDelegate,
                  UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        <#code#>
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        
    }
    
}
