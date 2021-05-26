//
//  TableViewInSecssion12.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

import UIKit

class TableViewInSecssion12: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var index : Int = 0
    var listImage1 = [Profile]()
    var listMostSuccessFullMovie1 = [Result]()

    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.init(hex: "17082A")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    func setupData(){
        DispatchQueue.main.async {
            self.myCollection.reloadData()
        }
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "CellForIndex1", bundle: nil), forCellWithReuseIdentifier: "cell1")
        myCollection.register(UINib(nibName: "CellForIndex2", bundle: nil), forCellWithReuseIdentifier: "cell2")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 1{
            return listImage1.count
        }else if index == 2 {
            return listMostSuccessFullMovie1.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if index == 1{
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CellForIndex1
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listImage1[indexPath.row].filePath )"), completed: nil)
            return cell
        }else if index == 2 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CellForIndex2
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listMostSuccessFullMovie1[indexPath.row].backdropPath ?? "")"), completed: nil)
            cell.lblNameFilm.text = listMostSuccessFullMovie1[indexPath.row].originalTitle
            cell.lblDate.text = listMostSuccessFullMovie1[indexPath.row].releaseDate
            cell.lblRated.text = String(Double(listMostSuccessFullMovie1[indexPath.row].voteAverage))
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index == 1{
            return CGSize(width: myCollection.frame.width/4, height: myCollection.frame.height)
        }else if index == 2{
            return CGSize(width: myCollection.frame.width/3, height: myCollection.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index == 1 {
            print("🥶\(indexPath.row)")
            let vc = PreViewImage()
            vc.modalPresentationStyle = .fullScreen
            vc.listImageCast = listImage1
            vc.index = indexPath.row
//           
           
            //vc.myCollection.scrollToItem(at: indexPath, at: .right, animated: true)
//            let image = listImage1[indexPath.row]
//            vc.nameCast = image.filePath
            
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }else if index == 2 {
            let vc = HomeDetailViewController()
            let movie = listMostSuccessFullMovie1[indexPath.row]
            vc.DetailID = movie.id
            UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        }
    }

}



