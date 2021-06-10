//
//  CollectionView0.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 08/06/2021.
//

import UIKit

class CollectionView0: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var myDataTvAir_today : TvAirToday?
    var listAir_Today = [Result_airToday]()

    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        contentView.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    func setupData(){
        FetchData.shared.getDataTvAir_Today(url: "https://api.themoviedb.org/3/tv/airing_today?api_key=3956f50a726a2f785334c24759b97dc6&language=en-US&page=1") { (data, true, error) in
            self.myDataTvAir_today = data
            self.listAir_Today = self.myDataTvAir_today?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
            
        }
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "Air_TodayCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAir_Today.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Air_TodayCell
        cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listAir_Today[indexPath.row].posterPath ?? "")"), completed: nil)
        cell.lblName.text = listAir_Today[indexPath.row].originalName
        cell.lblOverView.text = listAir_Today[indexPath.row].overview
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.width/2 + 50  , height: myCollection.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let tvshow = listAir_Today[indexPath.row]
        vc.Tv_id = tvshow.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
}
