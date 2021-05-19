//
//  HomeUpComing.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomeUpComing: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var myDataNowLaying : NowPlaying?
    var listUpComing = [Result]()

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
        myCollection.register(UINib(nibName: "UpComingCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        FetchData.shared.getDataNowPlaying(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
            self.myDataNowLaying = data
            self.listUpComing = self.myDataNowLaying?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }

        }
    }

    @IBAction func btnNext(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listUpComing.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UpComingCell{
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listUpComing[indexPath.row].posterPath ?? "")"), completed: nil)
            cell.lblName.text = listUpComing[indexPath.row].originalTitle
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
        return CGSize(width: myCollection.frame.size.width , height: myCollection.frame.size.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let movie = myDataNowLaying?.results[indexPath.row]
        vc.mydataNowPlaying = movie
        vc.DetailID = movie!.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
    
}
