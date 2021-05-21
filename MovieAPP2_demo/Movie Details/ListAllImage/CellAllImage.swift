//
//  CellAllImage.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class CellAllImage: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.layer.masksToBounds = true
        myImage.layer.cornerRadius = 10
        
        
    }
    
}
