//
//  HomeGenreCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomeGenreCell: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.textColor = .white
    }

}
