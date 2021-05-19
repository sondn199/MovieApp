//
//  CollectionCellOfSecsion4.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit

class CollectionCellOfSecsion4: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.layer.cornerRadius = 10
        myImage.layer.masksToBounds = true
    }

}
