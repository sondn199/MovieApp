//
//  CellOfSecsion0.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit
import Cosmos

class CellOfSecsion0: UITableViewCell {
    
//    var dataDetailcell01 : MovieDetail?
//    var dataDetailcell02 : MovieDetails?
    var id_movie : Int = 0
    
    var name : String = ""
    var Fav_name = [String]()
    var Fav_rated = [Double]()
    var Fav_date = [String]()

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
  
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var cosMosView: CosmosView!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var lblDateOfYear: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var readMoreView: ReadMoreLessView!
    let favoriteHelper = FavoriteHelper.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageFavorite()
        cosMosView.settings.fillMode = .precise
        cosMosView.settings.updateOnTouch = false
        cosMosView.backgroundColor = UIColor.init(hex: "200F37")
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        readMoreView.backgroundColor = UIColor.init(hex: "200F37")
        lblNameFilm.textColor = .white
        lblTime.textColor = .white
        lblDateOfYear.textColor = .white
        if checkFavorite(id: id_movie) == true{
            btnHeart.setImage(UIImage(named: "Vector-10"), for: .normal)
            
            
        }else{
            btnHeart.setImage(UIImage(named: "Vector-9"), for: .normal)
        }
        
 
    }
    func checkFavorite(id : Int)-> Bool{
        
        return false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func btnHeart(_ sender: Any) {
        if check() == false {
            Fav_name.append(name)
            print("😇\(Fav_name)")
        }
        if favoriteHelper.getFavoriteMovie(idMovie: id_movie) != nil {
            favoriteHelper.deleteFavoriteMovie(idMovie: id_movie)
           
            
           
        }
        else {
            favoriteHelper.addFavoriteMovie(idMovie: id_movie)
//            Fav_name.append(name)
//            print("😇\(Fav_name)")
        
        }
        setupImageFavorite()
       
    }
    
    func setupImageFavorite() {
        if favoriteHelper.getFavoriteMovie(idMovie: id_movie) != nil {
            btnHeart.setImage(UIImage(named: "Vector-10"), for: .normal)
           // Fav_name.append(name)
        }
        else {
            btnHeart.setImage(UIImage(named: "Vector-9"), for: .normal)
            
        }
    }
    func check() -> Bool{
        if(btnHeart.image(for: .normal) == UIImage(named: "Vector-10")){
            return true
        }
        return false
   
    }
    
}
