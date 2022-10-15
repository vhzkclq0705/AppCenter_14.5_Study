//
//  SecondViewController.swift
//  DataPassing
//
//  Created by 권오준 on 2022/10/15.
//

import UIKit

protocol DataPassDelegate {
    func updateTextField(_ text: String?)
}

class SecondViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Property
    
    var text: String?
    var delegate: DataPassDelegate?
    var closure: ((String?) -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
    }
    
    // MARK: - Func
    
    func configureViewController() {
        self.textField.text = self.text
    }
    
    // MARK: - Action

    @IBAction func back(_ sender: Any) {
        print("back")
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func updateAndBackWithDelegate(_ sender: Any) {
        print("updateAndBackWithDelegate")
        
        let text = self.textField.text
        self.delegate?.updateTextField(text)
        
        self.dismiss(animated: true)
    }
    
    @IBAction func updateAndBackWithClosure(_ sender: Any) {
        print("updateAndBackWithClosure")
        
        let text = self.textField.text
        self.closure?(text)
        
        self.dismiss(animated: true)
    }
    
    @IBAction func updateAndBackWithNotification(_ sender: Any) {
        print("updateAndBackWithNotification")
        
        let data: [String: String?] = ["text": self.textField.text]
        
        NotificationCenter.default.post(
            name: NSNotification.Name("DataPass"),
            object: nil,
            userInfo: data as [AnyHashable : Any])
        
        self.dismiss(animated: true)
    }
    
}
