//
//  FirstCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 21/05/2021.
//

import UIKit

class FirstCell: UICollectionViewCell {

    @IBOutlet weak var myLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        // Initialization code
    }

}
