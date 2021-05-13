//
//  CollectionViewOfSecssion2.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit
extension UIImageView{
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class CollectionViewOfSecssion2: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNameReal: UILabel!
    @IBOutlet weak var lblNameFake: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.backgroundColor = UIColor.init(hex: "200F37")
        lblNameReal.textColor = .white
        lblNameFake.textColor = UIColor.init(hex: "FFD0F3")
        //myImage.makeRounded()
        myImage.layer.borderWidth = 0.0
        myImage.layer.masksToBounds = false
        myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = myImage.frame.size.height/2
        myImage.clipsToBounds = true
    }

}

