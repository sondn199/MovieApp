//
//  HomeGenre.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 05/05/2021.
//

import UIKit

class HomeGenre: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var dataGenre : ListGenre?
    var listGenre = [Genre]()

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
        myCollection.register(UINib(nibName: "HomeGenreCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        FetchData.shared.getDataListGenre(url: "https://api.themoviedb.org/3/genre/movie/list?api_key=3956f50a726a2f785334c24759b97dc6") { (data, sucsess, error) in
            self.dataGenre = data
            self.listGenre = self.dataGenre?.genres ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
            }
        }
    }

    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGenre.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeGenreCell {
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.myImage.image = UIImage(named: "Mask Group\(indexPath.row + 1)")
            cell.backgroundImage.image = UIImage(named: "Rectangle 140\(indexPath.row + 1)")
           
            cell.lblName.text = listGenre[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.size.width/3 - 15, height: myCollection.frame.size.height/6)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vcGenre = ListMovieByGenreView()
        let movie = listGenre[indexPath.row]
        vcGenre.dataGenre = movie
        vcGenre.id = movie.id
        print("😇\(vcGenre.id)")
      //  vcGenre.NameFilm = "List Movie \(movie?.name ?? "")"
        UIApplication.getTopViewController()?.present(vcGenre, animated: true, completion: nil)
    }
   

}
