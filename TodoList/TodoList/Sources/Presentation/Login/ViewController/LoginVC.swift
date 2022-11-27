//
//  LoginVC.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import SnapKit
import SwiftUI
import Then
import UIKit

struct LoginVCPreview: PreviewProvider {
    static var previews: some View {
        LoginVC().toPreview()
    }
}

final class LoginVC: BaseViewController {
    
    // MARK: - UI
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40, weight: .bold)
        $0.text = "Login"
    }
    
    lazy var idInputView = InputView().then {
        $0.configureView("ID", "abcd")
    }
    
    lazy var passwordInputView = InputView().then {
        $0.configureView("Password", "12345")
    }
    
    lazy var okButton = UIButton().then {
        $0.configuration = makeOKButtonConfig()
        $0.addTarget(self, action: #selector(didTapOKButton), for: .touchUpInside)
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.tintColor = .lightGray
        $0.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
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
        [titleLabel, idInputView, passwordInputView, okButton, registerButton]
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
        
        passwordInputView.snp.makeConstraints {
            $0.top.equalTo(idInputView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(passwordInputView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    private func makeOKButtonConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.setColor(.button)
        config.baseForegroundColor = .white
        config.title = "확 인"
        
        return config
    }
    
    // MARK: - Action

    @objc private func didTapOKButton() {
        let model = Login(
            id: idInputView.textField.text ?? "",
            password: passwordInputView.textField.text ?? "")
        
        API.login(model) { [weak self] result in
            if result {
                self?.moveHomeViewController()
            }
        }
    }
    
    @objc private func didTapRegisterButton() {
        let vc = RegisterVC()
        self.present(vc, animated: true)
    }
    
}
