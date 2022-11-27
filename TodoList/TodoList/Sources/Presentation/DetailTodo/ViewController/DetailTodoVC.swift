//
//  DetailTodoVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import SnapKit
import SwiftUI
import Then
import UIKit

// MARK: - Preview

struct DetailTodoVCPreview: PreviewProvider {
    static var previews: some View {
        DetailTodoVC().toPreview()
    }
}

class DetailTodoVC: BaseViewController {
    
    // MARK: - UI
    
    lazy var backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var contentView = UIView().then {
        $0.backgroundColor = .setColor(.background)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    lazy var contentsTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.isEditable = false
    }
    
    lazy var completeSwitch = UISwitch().then {
        $0.onTintColor = UIColor.setColor(.button)
        $0.addTarget(self, action: #selector(didChangeSwitchState(_:)), for: .touchUpInside)
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        $0.tintColor = .red
        $0.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor.setColor(.button)
        $0.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    lazy var backgroundTapRecognizer = UITapGestureRecognizer().then {
        $0.addTarget(self, action: #selector(didTapCancelButton))
    }
    
    // MARK: - Property
    
    var id: Int!
    var todo: Todo? = nil {
        didSet {
            updateUI()
        }
    }
    var isUpdating = false {
        didSet {
            [completeSwitch, cancelButton, backgroundView]
                .forEach { $0.isUserInteractionEnabled = !isUpdating }
        }
    }
    var cancelHandler: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodo()
    }
    
    // MARK: - Setup
    
    override func configureViewController() {
        view.backgroundColor = .clear
    }
    
    override func addViews() {
        backgroundView.addGestureRecognizer(backgroundTapRecognizer)
        
        [contentsTextView, completeSwitch, deleteButton, cancelButton]
            .forEach { contentView.addSubview($0) }
        
        [backgroundView, contentView]
            .forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(completeSwitch.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        completeSwitch.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.bottom.width.equalTo(cancelButton)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - Func
    
    private func fetchTodo() {
        API.fetchOneTodo(id) { [weak self] todo in
            if let todo = todo {
                self?.todo = todo
            }
        }
    }
    
    private func updateTodo(_ isCompleted: Bool) {
        isUpdating = true
        let update = UpdateTodo(completed: isCompleted)
        
        API.updateTodo(id, update) { [weak self] response in
            if !response {
                self?.completeSwitch.isOn = !isCompleted
                self?.makeStrikeThrough(!isCompleted)
            }
            
            self?.isUpdating = false
        }
    }
    
    private func deleteTodo() {
        API.deleteTodo(id) { [weak self] response in
            if response {
                self?.dismissViewController()
            }
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            guard let isCompleted = self.todo?.isCompleted else {
                return
            }
            
            self.completeSwitch.isOn = isCompleted
            self.makeStrikeThrough(isCompleted)
        }
    }
    
    private func makeStrikeThrough(_ bool: Bool) {
        contentsTextView.attributedText = todo?.content.makeStrikeThrough(bool)
    }
    
    private func dismissViewController() {
        cancelHandler?()
        self.dismiss(animated: true)
    }
    
    // MARK: - Action

    @objc private func didTapCancelButton() {
        dismissViewController()
    }
    
    @objc private func didChangeSwitchState(_ sender: UISwitch) {
        if !isUpdating {
            updateTodo(sender.isOn)
            makeStrikeThrough(sender.isOn)
        }
    }
    
    @objc private func didTapDeleteButton() {
        deleteTodo()
    }
}
