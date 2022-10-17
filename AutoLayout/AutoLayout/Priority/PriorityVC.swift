//
//  PriorityVC.swift
//  AutoLayout
//
//  Created by 권오준 on 2022/10/17.
//

import UIKit

class PriorityVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet var leftLabels: [UILabel]!
    @IBOutlet var rightLabels: [UILabel]!
    
    // MARK: - Property
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Func
    
    
    // MARK: - Action
    
    @IBAction func firstButton(_ sender: Any) {
        self.leftLabels.forEach {
            $0.text = firstTextField.text
        }
    }
    
    @IBAction func secondButton(_ sender: Any) {
        self.rightLabels.forEach {
            $0.text = secondTextField.text
        }
    }
    
}
