//
//  CarouCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 29/04/2021.
//

import UIKit
import iCarousel
import SDWebImage

class CarouCell: UITableViewCell,iCarouselDataSource, iCarouselDelegate {

    var myDataDiscover : Discover?
    var listDiscover = [Result3]()
    
    @IBOutlet weak var myCarousel: iCarousel!
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupData()
        myCarousel.backgroundColor = UIColor.init(hex: "200F37")
        myCarousel.delegate = self
        myCarousel.dataSource = self
        myCarousel.type = .coverFlow
        myCarousel.centerItemWhenSelected = true
        myCarousel.isPagingEnabled = false
      //  myCarousel.scrollToItem(at: 1, animated: true)
        myCarousel.isPagingEnabled = true
       // myCarousel.autoscroll = -0.5
    
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        

    }
    
    func setupData(){
        FetchData.shared.getDataDiscover(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6") { (data, true, error) in
            
            self.myDataDiscover = data
           //      print("😤\(self.myDataDiscover)")
            self.listDiscover = self.myDataDiscover?.results ?? []
            //  print("😤\(self.listDiscover)")
            DispatchQueue.main.async {
                self.myCarousel.reloadData()
            }
        }
    }
    override func prepareForReuse() {
        imageView?.sd_cancelCurrentImageLoad()
        imageView?.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return listDiscover.count
       
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view  = UIView(frame: CGRect(x: 20, y: 20, width: myCarousel.frame.size.width/2 + 30 , height: myCarousel.frame.size.height - 50))
        let myImage = UIImageView(frame: view.bounds)
        
        view.addSubview(myImage)
        myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listDiscover[index].posterPath )"), placeholderImage: UIImage(named: "Rectangle 1412"), options: .continueInBackground, completed: .none)
//        myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listDiscover[index].posterPath )"), completed: nil)
      //  myImage.contentMode = .scaleAspectFill
       // myImage.image = UIImage(named: "\(index+1)")
//
        myCarousel.scrollToItem(at: 1, animated: false)

        return view
    }
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return 370
    }
}
