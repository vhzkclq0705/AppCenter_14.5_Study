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

struct ViewControllerPreview: PreviewProvider {
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
    }
    
    lazy var writeButton = UIButton().then {
        $0.configuration = configureWriteButton()
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    
    // MARK: - Property
    
    var todos = [
        Todo(contents: "ㅁㅈㄷㄹㄷㅈㄹㅁㄴㅇㄹㅈㄷㄹㅈwfwaefwefwefwefewfewfwefewf", id: 0, isCompleted: true),
        Todo(contents: "awe\nfwefasd\nfsdfsdfsdf", id: 1, isCompleted: false),
        Todo(contents: "ㅈㄷㄹㅁㅈㄹㅁㄴㅇㅇㄴㅊㅁㄴㅇ", id: 2, isCompleted: false),
        Todo(contents: "1413141313513513515", id: 3, isCompleted: true),
        Todo(contents: "ㅈㄷㄹ3ㅁㄹ2ㄹ2ㅇㅁ23ㅊㅇ2", id: 4, isCompleted: false),
        Todo(contents: "2ㅅㅍ4ㅍ535ㅇㄴ5345ㅇㄴ34ㅇ", id: 5, isCompleted: true),
        Todo(contents: "ㄴ36ㄹ3ㄹㄴㅍㄴㅎㄷㄱㅍㄱㄴㄱㄷ", id: 6, isCompleted: false),
        Todo(contents: "ㄴㅍ745ㅍ745\n25252vsce", id: 7, isCompleted: false),
        Todo(contents: "secgeg4seg4esrse4rs", id: 8, isCompleted: true),
        Todo(contents: "ㅁㅈㄷㄹㄷㅈㄹ3t43\nㅁㄴㅇㄹet4setㅈㄷㄹㅈ", id: 9, isCompleted: false),
    ]
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func configureWriteButton() -> UIButton.Configuration {
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
    
    
    // MARK: - Action
    
    @objc func didTapWriteButton(_ sender: Any) {
        
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
        
        var todo = todos[indexPath.row]
        cell.updateCell(todo)
        
        return cell
    }
    
}
