//
//  SingletonFirstVC.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import UIKit

class SingletonFirstVC: UIViewController {

    // MARK: - UI

    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Property
    
    let storage = Storage.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sg1" {
            storage.id = textField.text
        }
    }

}
