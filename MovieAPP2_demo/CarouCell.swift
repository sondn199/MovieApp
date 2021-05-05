//
//  CarouCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 29/04/2021.
//

import UIKit
import iCarousel

class CarouCell: UITableViewCell,iCarouselDataSource {
    let myCarousel : iCarousel = {
         let view = iCarousel()
         view.type = .coverFlow
        return view
     }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCarousel.dataSource = self
        myCarousel.frame = CGRect(x: 30, y: 20, width: contentView.frame.size.width, height: contentView.frame.size.height - 10)
        myCarousel.isPagingEnabled = true
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        contentView.addSubview(myCarousel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 6
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view  = UIView(frame: CGRect(x: 20, y: 20, width: myCarousel.frame.size.width/2 , height: myCarousel.frame.size.height - 30))
        let myImage = UIImageView(frame: view.bounds)
        view.addSubview(myImage)
        myImage.contentMode = .scaleAspectFill
        myImage.image = UIImage(named: "\(index+1)")
        return view
    }
    
}
