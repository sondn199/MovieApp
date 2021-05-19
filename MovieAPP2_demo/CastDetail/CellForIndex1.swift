//
//  CellForIndex1.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

import UIKit

class CellForIndex1: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        myImage.layer.masksToBounds = true
        myImage.layer.cornerRadius = 10
        // Initialization code
    }

}
