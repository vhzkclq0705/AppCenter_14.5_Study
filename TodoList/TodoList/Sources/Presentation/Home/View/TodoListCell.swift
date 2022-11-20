//
//  TodoListCell.swift
//  TodoList
//
//  Created by 권오준 on 2022/10/17.
//

import UIKit
import SwiftUI
import SnapKit
import Then

class TodoListCell: UITableViewCell {

    static let id = "cell"
    
    // MARK: - UI

    lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    lazy var contentsLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.numberOfLines = 2
    }
    
    lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .darkGray
    }
    
    lazy var bottomBorderView = UIView().then {
        $0.backgroundColor = .darkGray.withAlphaComponent(0.5)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func configureCell() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func addViews() {
        [nameLabel, dateLabel, contentsLabel, bottomBorderView]
            .forEach { contentView.addSubview($0) }
    }
    
    private func configureLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().inset(30)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        bottomBorderView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Func
    
    func updateCell(_ todo: Todo) {
        nameLabel.text = todo.name
        dateLabel.text = todo.date
        changeLabelState(todo.isCompleted, todo.contents)
    }
    
    private func changeLabelState(_ isCompleted: Bool, _ contents: String) {
        let attributedText: NSAttributedString
        
        if isCompleted {
            attributedText = NSAttributedString(
                string: contents,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            contentView.backgroundColor = .darkGray
        } else {
            attributedText = NSAttributedString(string: contents)
            contentView.backgroundColor = .clear
        }
        
        contentsLabel.attributedText = attributedText
    }
    
}
