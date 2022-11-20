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

struct TodoListCellPreview: PreviewProvider {
    static var previews: some View {
        TodoListCell().toPreview()
    }
}

class TodoListCell: UITableViewCell {

    static let id = "cell"
    
    // MARK: - UI

    lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    lazy var contentsLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.numberOfLines = 3
    }
    
    lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .darkGray
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentsLabel.attributedText = NSAttributedString(string: "")
    }
    
    // MARK: - Setup
    
    private func addViews() {
        [nameLabel, dateLabel, contentsLabel]
            .forEach { contentView.addSubview($0) }
    }
    
    private func configureLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalTo(nameLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: - Func
    
    func updateCell(_ todo: Todo) {
        nameLabel.text = todo.name
        dateLabel.text = todo.date
        changeLabelState(todo.isCompleted, todo.contents)
    }
    
    private func changeLabelState(_ isCompleted: Bool, _ contents: String) {
        let attributedText = isCompleted
        ? NSAttributedString(
            string: contents,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        : NSAttributedString(string: contents)
        
        contentsLabel.attributedText = attributedText
    }
    
}
