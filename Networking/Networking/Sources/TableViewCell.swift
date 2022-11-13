//
//  TableViewCell.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - UI
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        nameLabel.text = nil
        ageLabel.text = nil
        jobLabel.text = nil
    }
    
    // MARK: - Func
    
    private func updateCell(_ data: DataModel) {
        nameLabel.text = data.name
        ageLabel.text = "(\(data.age))"
        jobLabel.text = data.job
    }
    
    
    
}
