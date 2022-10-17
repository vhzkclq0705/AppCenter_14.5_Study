//
//  ChangeHeightVC.swift
//  AutoLayout
//
//  Created by 권오준 on 2022/10/17.
//

import UIKit

class ChangeHeightVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    // topView의 최소, 최대 높이
    let minHeight: CGFloat = 0
    let maxHeight: CGFloat = 130
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    // MARK: - Func
    
    func configureVC() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}

// MARK: - TableView Delegate & DataSource

extension ChangeHeightVC: UITableViewDelegate,
                          UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 위치, 스크롤을 내리면 증가
        let scrollPosition = scrollView.contentOffset.y
        
        // y = topView의 현재 높이 - 스크롤 뷰의 위치
        // 스크롤을 내리면 topView의 높이 감소
        let y = self.topViewHeight.constant - scrollPosition
        
        // y가 maxHeight보다 높으면 maxHeight로 유지
        if y > self.maxHeight {
            self.topViewHeight.constant = self.maxHeight
        }
        // y가 minHeight보다 낮으면 minHeight로 유지
        else if y < self.minHeight {
            self.topViewHeight.constant = self.minHeight
        }
        // y가 maxHeight과 minHeight의 사이면 topView의 높이는 y
        else {
            self.topViewHeight.constant = y
            
            // 자연스러운 움직임
            scrollView.contentOffset.y = 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return 30
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
}
