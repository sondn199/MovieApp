//
//  HomeTopRated.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomeTopRated: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var myDataPopular : Popular?
    var listTopRated = [Result]()

    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        view.backgroundColor = UIColor.init(hex: "17082A")
        HeaderView.backgroundColor = UIColor.init(hex: "200F37")
        myCollection.backgroundColor = UIColor.init(hex: "17082A")
        
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=3956f50a726a2f785334c24759b97dc6&page=1") { (data, success, error) in
            self.myDataPopular = data
            self.listTopRated = self.myDataPopular?.results ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
            
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTopRated.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myCollectionCell{
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listTopRated[indexPath.row].posterPath ?? "")"), completed: nil)
            cell.lblNameFilm.text = listTopRated[indexPath.row].originalTitle
            cell.lblRated.text = String(Double(listTopRated[indexPath.row].voteAverage))
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let movie = myDataPopular?.results[indexPath.row]
        vc.mydataPopular = movie
        vc.DetailID = movie!.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }

}
