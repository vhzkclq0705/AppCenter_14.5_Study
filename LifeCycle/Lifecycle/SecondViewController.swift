//
//  SecondViewController.swift
//  week_1
//
//  Created by 권오준 on 2022/10/11.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SecondVC-viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("SecondVC-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("SecondVC-viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("SecondVC-viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("SecondVC-viewDidDisappear")
    }
    
    // MARK: - Action
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
