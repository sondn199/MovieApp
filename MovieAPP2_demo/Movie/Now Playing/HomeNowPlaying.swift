//
//  HomeNowPlaying.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomeNowPlaying: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var myDataNowLaying : NowPlaying?
    var listNowPlaying = [Result]()
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hex: "17082A")
        HeaderView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "17082A")
        setupUI()
        setupData()
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        FetchData.shared.getDataNowPlaying(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
            self.myDataNowLaying = data
            self.listNowPlaying = self.myDataNowLaying?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }

        }
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listNowPlaying.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myCollectionCell{
            cell.lblTop.isHidden = true
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listNowPlaying[indexPath.row].posterPath)"), completed: nil)
            cell.lblNameFilm.text = listNowPlaying[indexPath.row].originalTitle
            cell.lblRated.text = String(Double(listNowPlaying[indexPath.row].voteAverage))
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
