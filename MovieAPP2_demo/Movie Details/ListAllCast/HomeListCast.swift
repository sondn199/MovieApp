//
//  HomeListCast.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class HomeListCast: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var listAllCast = [Cast]()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        view.backgroundColor = UIColor.init(hex: "17082A")
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
        myCollection.register(UINib(nibName: "CellListCast", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAllCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellListCast
        cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listAllCast[indexPath.row].profilePath ?? "")"), completed: nil)
        cell.lblNameReal.text = listAllCast[indexPath.row].name
        cell.lblNameFake.text = listAllCast[indexPath.row].character
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180   , height: 270)
    }

}
