//
//  TvGenreCell.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 07/06/2021.
//

import UIKit

class TvGenreCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var myDataGenre : ListGenre?
    var lisGenre = [Genre]()
    

    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "17082A")
        myCollection.backgroundColor = UIColor.init(hex: "17082A")
        setupData()
        setupUI()
    }
    func setupData(){
        FetchData.shared.getDataListGenre(url: "https://api.themoviedb.org/3/genre/movie/list?api_key=3956f50a726a2f785334c24759b97dc6") { (data, success, error) in
            self.myDataGenre = data
            self.lisGenre = self.myDataGenre?.genres ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
           
        }
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource  = self
        myCollection.register(UINib(nibName: "FirstCell", bundle: nil), forCellWithReuseIdentifier: "Genrecell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lisGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "Genrecell", for: indexPath) as! FirstCell
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.myLable.text = lisGenre[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.size.width/2 - 10 , height: myCollection.frame.size.height/8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let tvshow = lisGenre[indexPath.row]
        vc.DetailID = tvshow.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
}
