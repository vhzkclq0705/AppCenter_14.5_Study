//
//  NotSingletonFirstVC.swift
//  Singleton
//
//  Created by 권오준 on 2022/11/07.
//

import UIKit

class NotSingletonFirstVC: UIViewController {

    // MARK: - UI

    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nsg1" ,
           let vc = segue.destination as? NotSingletonSecondVC {
            vc.id = textField.text
        }
    }

}
