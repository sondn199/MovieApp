//
//  ListMovieByGenreCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 15/05/2021.
//

import UIKit

class ListMovieByGenreCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRated: UILabel!
    @IBOutlet weak var footerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        lblNameFilm.textColor = .white
        lblDate.textColor = .white
        footerView.backgroundColor = UIColor.init(hex: "200F37")
        footerView.layer.borderWidth = 0.5
        footerView.layer.borderColor = UIColor.white.cgColor
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
