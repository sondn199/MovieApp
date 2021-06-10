//
//  CarouCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 29/04/2021.
//

import UIKit
import iCarousel
import SDWebImage
import FSPagerView

class CarouCell: UITableViewCell,iCarouselDataSource, iCarouselDelegate {

    var myDataDiscover : Discover?
    var listDiscover = [Result3]()
    
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var myCarousel: iCarousel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupData()
        pageControl.backgroundColor = UIColor.init(hex: "200F37")
        myCarousel.backgroundColor = UIColor.init(hex: "200F37")
        myCarousel.delegate = self
        myCarousel.dataSource = self
        myCarousel.type = .coverFlow
        myCarousel.centerItemWhenSelected = true
       
        //  myCarousel.bounces = true
        myCarousel.isPagingEnabled = true
       // myCarousel.autoscroll = -0.5
        pageControl.numberOfPages = 10
        pageControl.currentPage = 1
    
        pageControl.contentHorizontalAlignment = .center
       
        pageControl.setStrokeColor(UIColor.white, for: .normal)
       // pageControl.setStrokeColor(UIColor.init(hex: "CBB5FF"), for: .normal)
        pageControl.setFillColor(UIColor.init(hex: "CBB5FF"), for: .normal)
        pageControl.itemSpacing = 10
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        
        //myCarousel.reloadData()
        

    }
    
    func setupData(){
        FetchData.shared.getDataDiscover(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6") { (data, true, error) in
            
            self.myDataDiscover = data
             //    print("😤\(self.myDataDiscover)")
            self.listDiscover = self.myDataDiscover?.results ?? []
            //  print("😤\(self.listDiscover)")
            DispatchQueue.main.async {
                self.myCarousel.reloadData()
               // self.myCarousel.scroll(byNumberOfItems: 2, duration: 0)
               
                self.myCarousel.scrollToItem(at: 1, animated: false)
                self.myCarousel.bounces = true
//                self.myCarousel.autoscroll = -0.5
              //  self.myCarousel.bounces = false
                
                
                

            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return listDiscover.count
       
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view  = UIView(frame: CGRect(x: 20, y: 20, width: myCarousel.frame.size.width/2 + 30 , height: myCarousel.frame.size.height - 10))
        let myImage = UIImageView(frame: view.bounds)
        
        view.addSubview(myImage)
       
            myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listDiscover[index].posterPath )"), completed: nil)
       
    
        return view
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        pageControl.currentPage = myCarousel.currentItemIndex / 2
    }
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return 370
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let vc = HomeDetailViewController()
        let movie = listDiscover[index]
        vc.DetailID = movie.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
    @IBAction func updatePageControl(_ sender: Any) {
        //myCarousel.scrollToItem(at: pageControl.currentPage * 3, animated: true)
        myCarousel.currentItemIndex = pageControl.currentPage
    }
    
}
