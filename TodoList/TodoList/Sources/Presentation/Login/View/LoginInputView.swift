//
//  LoginInputView.swift
//  TodoList
//
//  Created by 권오준 on 2022/11/20.
//

import SnapKit
import SwiftUI
import Then
import UIKit

struct LoginInputViewPreview: PreviewProvider {
    static var previews: some View {
        LoginInputView().toPreview()
    }
}

final class LoginInputView: UIView {
    
    // MARK: - UI
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.text = "test"
    }
    
    lazy var textField = UITextField().then {
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.clipsToBounds = true
        $0.placeholder = "test"
        $0.addLeftPadding()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func addViews() {
        [titleLabel, textField]
            .forEach { addSubview($0) }
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(30)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
    }
    
}
