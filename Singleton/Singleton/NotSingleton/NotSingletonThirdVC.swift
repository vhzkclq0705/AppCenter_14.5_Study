//
//  NotSingletonThirdVC.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import UIKit

class NotSingletonThirdVC: UIViewController {

    // MARK: - UI

    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Property
    
    var id: String?
    var password: String?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nsg3" ,
           let vc = segue.destination as? ResultVC {
            vc.id = id
            vc.password = password
            vc.age = textField.text
            vc.isSingleton = false
        }
    }

}
