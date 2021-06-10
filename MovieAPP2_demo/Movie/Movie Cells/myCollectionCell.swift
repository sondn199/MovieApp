//
//  myCollectionCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 16/04/2021.
//

import UIKit
import Cosmos

class myCollectionCell: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var lblRated: UILabel!
    @IBOutlet weak var cosMosView: CosmosView!
    @IBOutlet weak var myView: UIView!
    override func awakeFromNib() {
        myView.backgroundColor = UIColor.init(hex: "2B1462")
        lblNameFilm.textColor = .white
        lblRated.textColor = .white
        lblRated.textColor = UIColor.init(hex: "F79E44")
        cosMosView.settings.fillMode = .precise
        cosMosView.settings.updateOnTouch = false
        cosMosView.backgroundColor = UIColor.init(hex: "2B1462")
        super.awakeFromNib()
        
    }

}
