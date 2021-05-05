//
//  HomePopular.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomePopular: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var myDataPopular : Popular?
    var listPopular = [Result]()

    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "17082A")
        view.backgroundColor = UIColor.init(hex: "17082A")
        setupUI()
        setupData()
 
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/movie/popular?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
            self.myDataPopular = data
            self.listPopular = self.myDataPopular?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
            
        }
    }

    @IBAction func btnNext(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPopular.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myCollectionCell{
            cell.lblTop.isHidden = true
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listPopular[indexPath.row].posterPath)"), completed: nil)
            cell.lblNameFilm.text = listPopular[indexPath.row].originalTitle
            cell.lblRated.text = String(Double(listPopular[indexPath.row].voteAverage))
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.width/2 - 10, height: myCollection.frame.height/3 + 30 )
    }


}
