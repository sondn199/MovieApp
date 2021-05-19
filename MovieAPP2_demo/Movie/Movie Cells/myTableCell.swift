//
//  myTableCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 16/04/2021.
//

import UIKit
import SDWebImage
import iCarousel

class myTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource {
    
    var myDataPopular : Popular?
    var myDataNowLaying : NowPlaying?
    var myDataGenre : ListGenre?
    var index : Int = 10
    
    var popular1 = [Result]()
    var popular2 = [Result]()
    var popular3 = [Result]()
    var nowPlaying1 = [Result]()
    var nowPlaying2 = [Result]()
    var lisGenre = [Genre]()
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        myCollection.register(UINib(nibName: "GenreCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        myCollection.register(UINib(nibName: "UpComingCell", bundle: nil), forCellWithReuseIdentifier: "upComingCell")
    }
    func setupData(){
        if index == 0 {
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
        }
        if index == 1{
            FetchData.shared.getDataListGenre(url: "https://api.themoviedb.org/3/genre/movie/list?api_key=3956f50a726a2f785334c24759b97dc6") { (data, success, error) in
                self.myDataGenre = data
                self.lisGenre = self.myDataGenre?.genres ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
            }
            
        }else if index == 2{
            FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
                self.myDataPopular = data
                self.popular2 = self.myDataPopular?.results ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
                
            }
        }else if index == 3{
            FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/movie/popular?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
                self.myDataPopular = data
                self.popular3 = self.myDataPopular?.results ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
                
            }
        }else if index == 4{
            FetchData.shared.getDataNowPlaying(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
                self.myDataNowLaying = data
                self.nowPlaying1 = self.myDataNowLaying?.results ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
  
            }
        }else if index == 5{
            FetchData.shared.getDataNowPlaying(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
                self.myDataNowLaying = data
                self.nowPlaying2 = self.myDataNowLaying?.results ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
  
            }
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 6
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view  = UIView(frame: CGRect(x: 20, y: 0, width: 150 , height: 150))
        let myImage = UIImageView(frame: view.bounds)
        view.addSubview(myImage)
        myImage.contentMode = .scaleAspectFill
        myImage.image = UIImage(named: "\(index+1)")
        return view
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 1{
            return lisGenre.count
            
            
        }else if index == 2 {
            return popular2.count
                      
            
        }else if index == 3 {
            return popular3.count
          
            
        }else if index == 4 {
            return nowPlaying1.count
            
        }else if index == 5 {
            return nowPlaying2.count
            
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if  index == 1  {
           
            
                        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as? GenreCell{
                            if let mydataGenre = myDataGenre{
                                cell.layer.cornerRadius = 10
                                cell.layer.masksToBounds = true
                                cell.GenreImage.image = UIImage(named: "Mask Group\(indexPath.row + 1)")
                                cell.BackgoundImage.image = UIImage(named: "Rectangle 140\(indexPath.row + 1)")
                               
                                cell.lblName.text = mydataGenre.genres [indexPath.row].name
                            }
                            return cell
                        }
            
        }else  if index == 2 {
            if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? myCollectionCell{
                if let mydataPopular = myDataPopular{
                    cell.layer.cornerRadius = 8
                   
                    cell.layer.masksToBounds = true
                    cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(mydataPopular.results[indexPath.row].posterPath ?? "")"), completed: nil)
                    cell.lblNameFilm.text = mydataPopular.results[indexPath.row].originalTitle
                    cell.lblRated.text = String(Double(mydataPopular.results[indexPath.row].voteAverage))
                }
                
                return cell
            }
            
        }else if index == 3 {
            if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? myCollectionCell{
                if let mydataPopular = myDataPopular{
                    cell.lblTop.isHidden = true
                    cell.layer.cornerRadius = 8
                   
                    cell.layer.masksToBounds = true
                    cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(mydataPopular.results[indexPath.row].posterPath ?? "")"), completed: nil)
                    cell.lblNameFilm.text = mydataPopular.results[indexPath.row].originalTitle
                    cell.lblRated.text = String(Double((mydataPopular.results[indexPath.row].voteAverage)))
                }
                return cell
            }
            
        }else if index == 4 {
  
            if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? myCollectionCell{
                if let mydataNowPlaying = myDataNowLaying{
                    cell.layer.cornerRadius = 8
                   
                    cell.layer.masksToBounds = true
                    cell.lblTop.isHidden = true
                    cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(mydataNowPlaying.results[indexPath.row].posterPath ?? "")"), completed: nil)
                    cell.lblNameFilm.text = mydataNowPlaying.results[indexPath.row].originalTitle
                    cell.lblRated.text = String(Double((mydataNowPlaying.results[indexPath.row].voteAverage)))
                }
                return cell
            }
            
        }else if index == 5 {
            
            if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as? UpComingCell{
                if let mydataNowPlaying = myDataNowLaying{
                    cell.layer.cornerRadius = 15
                    cell.layer.masksToBounds = true
                    cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(mydataNowPlaying.results[indexPath.row].posterPath ?? "")"), completed: nil)
                    cell.lblName.text = mydataNowPlaying.results[indexPath.row].originalTitle
                    
                }
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index == 1 {
            
             return CGSize(width: myCollection.frame.width/3 - 10, height: myCollection.frame.height - 40  )
            
            
        }else if index == 2 {
            return CGSize(width: myCollection.frame.width/3 - 10  , height: myCollection.frame.height )
          
            
        }else if index == 3 {
            return CGSize(width: myCollection.frame.width/3 - 10 , height: myCollection.frame.height  )
           
            
        }else if index == 4 {
            return CGSize(width: myCollection.frame.width/3 - 10, height: myCollection.frame.height )
            
            
        }else if index == 5 {
            return CGSize(width: myCollection.frame.width/2 + 50  , height: myCollection.frame.height)
            
            
        }
        return CGSize(width: myCollection.frame.width/4, height: myCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        
        if index == 2 {
            let movie = myDataPopular?.results[indexPath.row]
            vc.mydataPopular = movie
            vc.DetailID = movie!.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 3 {
            let movie = myDataPopular?.results[indexPath.row]
            vc.mydataPopular = movie
            vc.DetailID = movie!.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 4 {
            let movie = myDataNowLaying?.results[indexPath.row]
            vc.mydataNowPlaying = movie
            vc.DetailID = movie!.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 5 {
            let movie = myDataNowLaying?.results[indexPath.row]
            vc.mydataNowPlaying = movie
            vc.DetailID = movie!.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 1{
            let vcGenre = ListMovieByGenreView()
            let movie = myDataGenre?.genres[indexPath.row]
            vcGenre.dataGenre = movie
            vcGenre.id = movie?.id ?? 0
          //  vcGenre.NameFilm = "List Movie \(movie?.name ?? "")"
            UIApplication.getTopViewController()?.present(vcGenre, animated: true, completion: nil)
        }
    
}
}


