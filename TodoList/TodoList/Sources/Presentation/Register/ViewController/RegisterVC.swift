//
//  RegisterVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import SnapKit
import SwiftUI
import Then
import UIKit

struct RegisterViewPreview: PreviewProvider {
    static var previews: some View {
        RegisterVC().toPreview()
    }
}

class RegisterVC: BaseViewController {

    // MARK: - UI
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40, weight: .bold)
        $0.text = "Register"
    }
    
    lazy var idInputView = InputView().then {
        $0.configureView("ID", "abcd")
    }
    
    lazy var emailInputView = InputView().then {
        $0.configureView("Email", "abcd@inu.ac.kr")
    }
    
    lazy var passwordInputView = InputView().then {
        $0.configureView("Password", "12345")
    }
    
    lazy var nameInputView = InputView().then {
        $0.configureView("Name", "jun")
    }
    
    lazy var ageInputView = InputView().then {
        $0.configureView("Age", "25")
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("Cancel", for: .normal)
        $0.setTitleColor(UIColor.setColor(.button), for: .normal)
        $0.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    lazy var okButton = UIButton().then {
        $0.setTitle("OK", for: .normal)
        $0.setTitleColor(UIColor.setColor(.button), for: .normal)
        $0.addTarget(self, action: #selector(didTapOKButton), for: .touchUpInside)
    }

    
    // MARK: - Property
    
    let loginManager = LoginManager.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configureLayout()
    }
    
    // MARK: - Setup
    
    override func addViews() {
        [
            titleLabel,
            idInputView,
            emailInputView,
            passwordInputView,
            nameInputView,
            ageInputView,
            cancelButton,
            okButton
        ]
            .forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
        }
        
        idInputView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        emailInputView.snp.makeConstraints {
            $0.top.equalTo(idInputView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        passwordInputView.snp.makeConstraints {
            $0.top.equalTo(emailInputView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameInputView.snp.makeConstraints {
            $0.top.equalTo(passwordInputView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(view.snp.centerX)
        }
        
        ageInputView.snp.makeConstraints {
            $0.top.equalTo(passwordInputView.snp.bottom)
            $0.leading.equalTo(view.snp.centerX)
            $0.trailing.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Func
    
    private func makeOKButtonConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .darkGray
        config.baseForegroundColor = .white
        config.title = "확 인"
        
        return config
    }
    
    // MARK: - Action

    @objc private func didTapOKButton() {
        let model = SignUp(
            age: Int(ageInputView.textField.text ?? "20") ?? 20,
            email: emailInputView.textField.text ?? "",
            memberId: idInputView.textField.text ?? "",
            name: nameInputView.textField.text ?? "",
            password: passwordInputView.textField.text ?? "")
        
        API.signUp(model) { [weak self] result in
            if result {
                self?.dismiss(animated: true)
            }
        }
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }

}
