//
//  WriteVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/21.
//

import SnapKit
import SwiftUI
import Then
import UIKit

// MARK: - Preview

struct WriteTodoVCPreview: PreviewProvider {
    static var previews: some View {
        WriteTodoVC().toPreview()
    }
}

class WriteTodoVC: BaseViewController {
    
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
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .lightGray
    }
    
    lazy var completeSwitch = UISwitch().then {
        $0.onTintColor = UIColor.setColor(.button)
        $0.addTarget(self, action: #selector(didChangeSwitchState(_:)), for: .valueChanged)
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor.setColor(.button)
        $0.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    lazy var submitButton = UIButton().then {
        $0.applyCustomConfig("확 인")
        $0.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }
    
    lazy var backgroundTapRecognizer = UITapGestureRecognizer().then {
        $0.addTarget(self, action: #selector(didTapBackgroundView))
    }
    
    // MARK: - Property
    
    var cancelHandler: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    override func configureViewController() {
        view.backgroundColor = .clear
        contentsTextView.becomeFirstResponder()
    }
    
    override func addViews() {
        backgroundView.addGestureRecognizer(backgroundTapRecognizer)
        
        [contentsTextView, completeSwitch, cancelButton, submitButton]
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
            $0.bottom.equalTo(submitButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        completeSwitch.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(25)
        }
        
        submitButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Func
    
    private func createTodo() {
        let create = CreatTodo(
            content: contentsTextView.text ?? "",
            isCompleted: completeSwitch.isOn)
        
        API.createTodo(create) { [weak self] response in
            if response {
                self?.cancelHandler?()
                self?.dismiss(animated: true)
            }
        }
    }
    
    private func dismissViewController() {
        cancelHandler?()
        self.dismiss(animated: true)
    }
    
    // MARK: - Action

    @objc private func didTapCancelButton() {
        dismissViewController()
    }
    
    @objc private func didTapBackgroundView() {
        if contentsTextView.isFirstResponder {
            print("a")
            view.endEditing(true)
        } else {
            print("b")
            dismissViewController()
        }
    }

    @objc private func didChangeSwitchState(_ sender: UISwitch) {
        guard let text = contentsTextView.text else {
            return
        }
        
        contentsTextView.attributedText = text.makeStrikeThrough(sender.isOn)
    }
    
    @objc private func didTapSubmitButton() {
        createTodo()
    }
    
}
