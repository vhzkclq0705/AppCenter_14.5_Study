//
//  ViewController.swift
//  week_1
//
//  Created by 권오준 on 2022/10/11.
//

//  Practice iOS Life cycle

import UIKit

class FirstViewController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("FistVC-viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("FistVC-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("FistVC-viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("FistVC-viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("FistVC-viewDidDisappear")
    }

}

