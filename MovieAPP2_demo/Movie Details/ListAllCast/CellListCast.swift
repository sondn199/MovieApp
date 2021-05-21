//
//  CellListCast.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class CellListCast: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNameReal: UILabel!
    @IBOutlet weak var lblNameFake: UILabel!
    @IBOutlet weak var footerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        footerView.backgroundColor = UIColor.init(hex: "200F37")
        lblNameReal.textColor = .white
        lblNameFake.textColor = UIColor.init(hex: "FFD0F3")
        myImage.layer.borderWidth = 1.0
        myImage.layer.masksToBounds = false
       // myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = myImage.frame.size.height/2
        myImage.clipsToBounds = true
        // Initialization code
    }

}
