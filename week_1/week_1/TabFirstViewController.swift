//
//  TabViewController.swift
//  week_1
//
//  Created by 권오준 on 2022/10/15.
//

import UIKit

class TabFirstViewController: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TabBar-First-viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("TabBar-First-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("TabBar-First-viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("TabBar-First-viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("TabBar-First-viewDidDisappear")
    }

}
