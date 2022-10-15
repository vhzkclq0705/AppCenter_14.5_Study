//
//  ViewController.swift
//  DataPassing
//
//  Created by 권오준 on 2022/10/15.
//

import UIKit

class FirstViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Property
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DataPass" {
            guard let vc = segue.destination as? SecondViewController else {
                return
            }
        
            // 다음 코드가 에러를 발생시키는 이유는?
            // vc.textField.text = self.textField.text
            
            // Delegate를 이용한 데이터 전달
//            vc.delegate = self
            
            // Closure를 이용한 데이터 전달
//            vc.closure = { text in
//                self.textField.text = text
//            }
            
            // Notification을 이용한 데이터 전달
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(updateTextFieldWithNotification(_:)),
                name: NSNotification.Name("DataPass"),
                object: nil)
            
            vc.text = self.textField.text
        }
    }
    
    // MARK: - Action

    @IBAction func dataPassingWithSegue(_ sender: Any) {
        print("dataPassingWithSegue")
    }
    
    @IBAction func dataPassingWithoutSegue(_ sender: Any) {
        print("dataPassingWithoutSegue")
        
        guard let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        vc.delegate = self
        vc.text = self.textField.text
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func updateTextFieldWithNotification(_ notification: NSNotification) {
        print("updateTextFieldWithNotification")
        
        if let data = notification.userInfo as? NSDictionary,
           let text = data["text"] as? String? {
            self.textField.text = text
        } else {
            print("Failed")
        }
    }
    
}

// MARK: - DataPassDelegate

extension FirstViewController: DataPassDelegate {
    
    func updateTextField(_ text: String?) {
        self.textField.text = text
    }
    
}
