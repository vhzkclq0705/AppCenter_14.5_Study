//
//  ViewController.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import UIKit

class ResultVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK: - Property
    
    let storage = Storage.shared
    var isSingleton: Bool?
    var id: String?
    var password: String?
    var age: String?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }

    // MARK: - Func
    
    private func configureViewController() {
        guard let isSingleton = isSingleton else { return }
        
        if isSingleton {
            idLabel.text = storage.id
            passwordLabel.text = storage.password
            ageLabel.text = storage.age
        } else {
            idLabel.text = id
            passwordLabel.text = password
            ageLabel.text = age
        }
        
    }

}

