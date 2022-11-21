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
    
    lazy var contentView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    lazy var contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .lightGray
        $0.numberOfLines = 15
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
    
    // MARK: - Property
    
    var todo: Todo?
    var cancelHandler: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    override func configureViewController() {
        view.backgroundColor = .setColor(.background)
        
        let bool = todo?.isCompleted ?? false
        completeSwitch.isOn = bool
        makeStrikeThrough(bool)
    }
    
    override func addViews() {
        [contentsLabel, completeSwitch, cancelButton]
            .forEach { contentView.addSubview($0) }
        
        view.addSubview(contentView)
    }
    
    override func configureLayout() {
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(completeSwitch.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        completeSwitch.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - Func
    
    private func makeStrikeThrough(_ bool: Bool) {
        contentsLabel.attributedText = todo?.content.makeStrikeThrough(bool)
    }
    
    
    // MARK: - Action

    @objc private func didTapCancelButton() {
        cancelHandler?()
        self.dismiss(animated: true)
    }
    
    @objc private func didChangeSwitchState(_ sender: UISwitch) {
        makeStrikeThrough(sender.isOn)
        
        if sender.isOn {
            // POST - isCompleted = true
        } else {
            // POST - isCompleted = false
        }
    }
    
}
