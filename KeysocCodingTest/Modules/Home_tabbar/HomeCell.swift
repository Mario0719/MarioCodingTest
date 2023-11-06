//
//  HomeCell.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/6.
//

import UIKit

class HomeCell: UITableViewCell {    
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var lab_subTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
