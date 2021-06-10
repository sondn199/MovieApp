//
//  TvShowTableCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/06/2021.
//

import UIKit

class TvShowTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var index : Int = 0
   
    var myDataTvOntheAir : TvAirToday?
    var listTVOntheAir = [Result_airToday]()
    var myDataTvTopRated : TvAirToday?
    var listTvTopRated = [Result_airToday]()
    var myDataTvPopular : TvPopular?
    var listTvPopular = [Result_Tvpopular]()
   
    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.frame = myCollection.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        setupData()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func setupData(){
        
        FetchData.shared.getDataTvPopular(url: "https://api.themoviedb.org/3/tv/popular?api_key=3956f50a726a2f785334c24759b97dc6&language=en-US&page=1") { (data, true, eroor) in
            self.myDataTvPopular = data
            self.listTvPopular = self.myDataTvPopular?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
        }
        FetchData.shared.getDataTvAir_Today(url: "https://api.themoviedb.org/3/tv/on_the_air?api_key=3956f50a726a2f785334c24759b97dc6&language=en-US&page=1") { (data, true, error) in
            self.myDataTvOntheAir = data
            self.listTVOntheAir = self.myDataTvOntheAir?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
        }
        FetchData.shared.getDataTvAir_Today(url: "https://api.themoviedb.org/3/tv/top_rated?api_key=3956f50a726a2f785334c24759b97dc6&language=en-US&page=1") { (data, sussec, error) in
            self.myDataTvTopRated = data
            self.listTvTopRated = self.myDataTvTopRated?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
        }
        
        
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "Air_TodayCell", bundle: nil), forCellWithReuseIdentifier: "airTodayCell")
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 1 {
            return listTvTopRated.count
        }else if index == 2 {
            return listTVOntheAir.count
        }else  {
            return listTvPopular.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if index == 1 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionCell
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listTvTopRated[indexPath.row].posterPath ?? "")"), completed: nil)
            cell.lblNameFilm.text = listTvTopRated[indexPath.row].originalName
            cell.lblRated.text = String(Double(listTvTopRated[indexPath.row].voteAverage ?? 0.0))
            cell.cosMosView.rating = (listTvTopRated[indexPath.row].voteAverage ?? 0.0)/2
            return cell
        }else if index == 2 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionCell
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listTVOntheAir[indexPath.row].posterPath ?? "")"), completed: nil)
            cell.lblNameFilm.text = listTVOntheAir[indexPath.row].originalName
            cell.lblRated.text = String(Double(listTVOntheAir[indexPath.row].voteAverage ?? 0.0))
            cell.cosMosView.rating = (listTVOntheAir[indexPath.row].voteAverage ?? 0.0)/2
            return cell
        }else if index == 3 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionCell
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listTvPopular[indexPath.row].posterPath )"), completed: nil)
            cell.lblNameFilm.text = listTvPopular[indexPath.row].originalName
            cell.lblRated.text = String(Double(listTvPopular[indexPath.row].voteAverage ))
            cell.cosMosView.rating = (listTvPopular[indexPath.row].voteAverage )/2
            return cell
        }
        return UICollectionViewCell()
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 6
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if index == 1 {
            return CGSize(width: myCollection.frame.width/3 - 10  , height: myCollection.frame.height )
        }else if index == 2 {
            return CGSize(width: myCollection.frame.width/3 - 10  , height: myCollection.frame.height )
        }else if index == 3 {
            return CGSize(width: myCollection.frame.width/3 - 10  , height: myCollection.frame.height )
        }
       return CGSize.zero
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
         if index == 1 {
            let tvshow = listTvTopRated[indexPath.row]
            vc.Tv_id = tvshow.id
            print("😇\(vc.Tv_id)")
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 2 {

            let tvshow = listTVOntheAir[indexPath.row]
            vc.Tv_id = tvshow.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 3 {

            let tvshow = listTvPopular[indexPath.row]
            vc.Tv_id = tvshow.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }
    }
}

