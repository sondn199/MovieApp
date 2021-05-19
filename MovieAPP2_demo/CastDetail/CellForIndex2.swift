//
//  CellForIndex2.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

import UIKit

class CellForIndex2: UICollectionViewCell {

    @IBOutlet weak var FooterView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRated: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        FooterView.backgroundColor = UIColor.init(hex: "200F37")
        lblNameFilm.textColor = .white
        lblDate.textColor = .white
        lblRated.textColor = .white
        // Initialization code
    }

}
