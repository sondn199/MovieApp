//
//  RecentCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 18/05/2021.
//

import UIKit

class RecentCell: UITableViewCell {

    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblHistorySearch: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        contentView.backgroundColor = UIColor.init(hex: "17082A")
        viewtop.backgroundColor = UIColor.init(hex: "200F37")
        viewBottom.backgroundColor = UIColor.init(hex: "200F37")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
