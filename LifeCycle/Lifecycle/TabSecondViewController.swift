//
//  TabSecondViewController.swift
//  week_1
//
//  Created by 권오준 on 2022/10/15.
//

import UIKit

class TabSecondViewController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TabBar-Second-viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("TabBar-Second-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("TabBar-Second-viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("TabBar-Second-viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("TabBar-Second-viewDidDisappear")
    }

}
