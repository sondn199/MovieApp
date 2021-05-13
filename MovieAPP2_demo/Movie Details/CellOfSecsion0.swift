//
//  CellOfSecsion0.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit

class CellOfSecsion0: UITableViewCell {
    
    var dataDetailcell01 : MovieDetail?
    var dataDetailcell02 : MovieDetails?

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var lblDateOfYear: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var txtOverView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        txtOverView.backgroundColor = UIColor.init(hex: "200F37")
        txtOverView.textColor = .systemGray4
        lblNameFilm.textColor = .white
        lblTime.textColor = .white
        lblDateOfYear.textColor = .white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBOutlet weak var btnHeart: UIImageView!
    
}
