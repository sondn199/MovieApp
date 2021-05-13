//
//  DetailCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit
class DetailCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var myCollection: UICollectionView!
    
    var index : Int = 0
    var listCast1 = [Cast]()
    var myDataPopular : Popular?
    var popular2 = [Result]()
    var backdrop_path : String = ""
    var poter_path1 : String = ""
    var vote_average1 : Double = 0.0
    var nameTitle1 : String = ""
    var ThumbnailYoutube = [Result1]()

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
        
    
    }
    func setupData(){
        if index == 5 {
            FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6&with_genres=28&page=1") { (data, success, error) in
                self.myDataPopular = data
                self.popular2 = self.myDataPopular?.results ?? []
                DispatchQueue.main.async {
                    self.myCollection.reloadData()
                }
                
            }
        }
        DispatchQueue.main.async {
            self.myCollection.reloadData()
        }
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "CollectionCellOfSecsion1", bundle: nil), forCellWithReuseIdentifier: "cell1")
        myCollection.register(UINib(nibName: "CollectionViewOfSecssion2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        myCollection.register(UINib(nibName: "CollectionCellOfSecsion35", bundle: nil), forCellWithReuseIdentifier: "cell35")
        myCollection.register(UINib(nibName: "CollectionCellOfSecsion4", bundle: nil), forCellWithReuseIdentifier: "cell4")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 5{
            return popular2.count
        }else if index == 3 || index == 4 {
            return 1
        }else if index == 1 {
            return ThumbnailYoutube.count
        }
        return listCast1.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if index == 1{
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionCellOfSecsion1
           // cell.key = ThumbnailYoutube[indexPath.row].key
            cell.playerView.load(withVideoId: ThumbnailYoutube[indexPath.row].key)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            
           // print("🙃\(cell.key)")
            return cell
        }else if index == 2 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewOfSecssion2
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listCast1[indexPath.row].profilePath ?? "")"), completed: nil)
            cell.lblNameReal.text = listCast1[indexPath.row].name
            cell.lblNameFake.text = listCast1[indexPath.row].character
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }else if index == 4 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! CollectionCellOfSecsion4
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(poter_path1)"), completed: nil)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }else if index == 3 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell35", for: indexPath) as! CollectionCellOfSecsion35
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(backdrop_path)"), completed: nil)
            cell.lblName.text = nameTitle1
            cell.lblRated.text = String(Double(vote_average1))
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }else if index == 5 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell35", for: indexPath) as! CollectionCellOfSecsion35
            if let mydata = myDataPopular{
                
            
            
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(mydata.results[indexPath.row].posterPath)"), completed: nil)
            cell.lblName.text = mydata.results[indexPath.row].originalTitle
                cell.lblRated.text = String(Double(mydata.results[indexPath.row].voteAverage ))
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
            return cell
            }
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index == 1 {
            return CGSize(width: myCollection.frame.size.width/2, height: myCollection.frame.size.height )
        }else if index == 4 {
            return CGSize(width: myCollection.frame.size.width - 100 , height: myCollection.frame.size.height )
        }
        return CGSize(width: myCollection.frame.size.width/3, height: myCollection.frame.size.height )
    }
}
