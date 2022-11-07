//
//  NotSingletonSecondVC.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import UIKit

class NotSingletonSecondVC: UIViewController {

    // MARK: - UI

    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Property
    
    var id: String?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nsg2" ,
           let vc = segue.destination as? NotSingletonThirdVC {
            vc.id = id
            vc.password = textField.text
        }
    }

}
