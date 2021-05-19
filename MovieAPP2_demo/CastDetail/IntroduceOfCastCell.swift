//
//  IntroduceOfCastCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

import UIKit

class IntroduceOfCastCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNameCast: UILabel!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblIntruduce: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        lblIntruduce.numberOfLines = 0
        lblNameCast.textColor = .white
        lblDateOfBirth.textColor = .white
        lblAddress.textColor = .white
        lblIntruduce.textColor = .white
        // Initialization code
        myImage.layer.borderWidth = 1.0
        myImage.layer.masksToBounds = false
        myImage.layer.cornerRadius = myImage.frame.size.height/2
        myImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
