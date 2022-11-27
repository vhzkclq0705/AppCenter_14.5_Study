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

// MARK: - Preview

struct HomeVCPreview: PreviewProvider {
    static var previews: some View {
        HomeVC().toPreview()
    }
}

final class HomeVC: BaseViewController {
    
    // MARK: - UI
    
    lazy var tableView = UITableView().then {
        $0.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.id)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.refreshControl = UIRefreshControl()
        $0.refreshControl?.addTarget(
            self,
            action: #selector(refreshTableView),
            for: .valueChanged)
    }
    
    lazy var writeButton = UIButton().then {
        $0.configuration = makeWriteButtonConfig()
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    // MARK: - Property
    
    var todos: [Todo] = [] {
        didSet {
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
    }
    
    // MARK: - Setup
    
    override func configureNavigationBar() {
        self.navigationItem.title = "TodoList"
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func addViews() {
        [tableView, writeButton]
            .forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.top.edges.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Func
    
    private func fetchTodos() {
        API.fetchAllTodos() { [weak self] todos in
            self?.todos = todos
        }
    }
    
    private func makeWriteButtonConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = #colorLiteral(red: 0.1510773897, green: 0.1510773897, blue: 0.1510773897, alpha: 1)
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "pencil")?.withTintColor(
            .red,
            renderingMode: .alwaysOriginal)
        config.imagePadding = 10
        config.title = "Write"
        
        return config
    }
    
    private func changeViewBackgroundAlpha(_ isDetail: Bool) {
        view.alpha = isDetail ? 0.3 : 1
    }
    
    // MARK: - Action
    
    @objc private func refreshTableView() {
        fetchTodos()
    }
    
    @objc private func didTapWriteButton() {
        
    }
}

extension HomeVC: UITableViewDelegate,
                  UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return todos.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodoListCell.id, for: indexPath) as? TodoListCell else {
            return UITableViewCell()
        }
        
        let todo = todos[indexPath.row]
        cell.updateCell(todo)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        let vc = DetailTodoVC()
        vc.id = todos[indexPath.row].id
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.cancelHandler = {
            self.changeViewBackgroundAlpha(false)
        }
        
        changeViewBackgroundAlpha(true)
        self.present(vc, animated: true)
    }
    
}
