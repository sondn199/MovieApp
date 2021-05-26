//
//  ListMovieByGenreView.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 15/05/2021.
//

import UIKit

class ListMovieByGenreView: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    
    
    var genre : Popular?
    var listGenre = [Result]()
    var dataGenre : Genre!
    var id : Int = 0
    var data1 = [Result]()
    var lisGenre1 = [Genre]()
  //  var genre_id : Int = 0

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var NameFilm: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //myTable.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        if dataGenre != nil{
            NameFilm.text = "List Movie \(dataGenre.name )"
        }
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        view.backgroundColor = UIColor.init(hex: "17082A")
        myCollection.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
        
    }
//    func check(){
//        for i in listGenre {
//            if i.genreIDS.contains(id){
//                data1.append(i)
//
//            }
//        }
//       // print("🙃\(data1)")
//    }
    @IBAction func brnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setupData(){
        FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6&with_genres=\(id)&page=1") { (data, true, error) in
            self.genre = data
            self.listGenre = self.genre?.results ?? []
           // print("🥶\(self.listGenre)")
          //  self.check()
            DispatchQueue.main.async {
                let offset = self.myCollection.contentOffset
                self.myCollection.reloadData()
                self.myCollection.layoutIfNeeded()
                self.myCollection.setContentOffset(offset, animated: false)
            }
        }
    }
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "myCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myCollectionCell{
            if listGenre.count != 0 {
            
                cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listGenre[indexPath.row].backdropPath ?? "")"), completed: nil)
                cell.myImage.layer.cornerRadius = 10
                cell.lblTop.isHidden = true
                    cell.lblNameFilm.text = listGenre [indexPath.row].originalTitle
                    cell.lblRated.text = String(listGenre[indexPath.row].voteAverage)
                   
                cell.backgroundColor = UIColor.init(hex: "200F37")
             return cell
            }

        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.width/2 - 10, height: myCollection.frame.height/2 - 30  )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let movie = listGenre[indexPath.row]
        vc.DetailID = movie.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
    

}
