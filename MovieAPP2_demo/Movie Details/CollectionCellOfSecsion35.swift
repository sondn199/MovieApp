//
//  CollectionCellOfSecsion35.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit

class CollectionCellOfSecsion35: UICollectionViewCell {

    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRated: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        myview.backgroundColor = UIColor.init(hex: "200F37")
        lblName.textColor = .white
        lblRated.textColor = .white
    }

}
