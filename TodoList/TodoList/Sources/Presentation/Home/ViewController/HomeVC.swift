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
        $0.dataSource = self
        $0.delegate = self
        $0.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.id)
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    lazy var writeButton = UIButton().then {
        $0.configuration = configureWriteButton()
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    
    // MARK: - Property
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    override func configureNavigationBar() {
        self.navigationItem.title = "TodoList"
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
        config.baseBackgroundColor = .darkGray
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
