//
//  ListMovieByGenreView.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 15/05/2021.
//

import UIKit

class ListMovieByGenreView: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var genre : Popular?
    var listGenre = [Result]()
    var dataGenre : Genre!
    var id : Int = 0
    var data1 = [Result]()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var NameFilm: UILabel!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NameFilm.text = "List Movie \(dataGenre.name)"
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        view.backgroundColor = UIColor.init(hex: "17082A")
        myTable.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
        
    }
    func check(){
        for i in listGenre {
            if i.genreIDS.contains(id){
                data1.append(i)
                
            }
        }
       // print("🙃\(data1)")
    }
    func setupData(){
        FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6&with_genres=28&page=1") { (data, true, error) in
            self.genre = data
            self.listGenre = self.genre?.results ?? []
           // print("🥶\(self.listGenre)")
            self.check()
            DispatchQueue.main.async {
                let offset = self.myTable.contentOffset
                self.myTable.reloadData()
                self.myTable.layoutIfNeeded()
                self.myTable.setContentOffset(offset, animated: false)
            }
        }
    }
    func setupUI(){
        myTable.delegate = self
        myTable.dataSource = self
        myTable.register(UINib(nibName: "ListMovieByGenreCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListMovieByGenreCell{
            if listGenre.count != 0 {
            
                cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(data1[indexPath.row].backdropPath ?? "")"), completed: nil)
                cell.myImage.layer.cornerRadius = 10
                    cell.lblNameFilm.text = data1[indexPath.row].originalTitle
                    cell.lblDate.text = data1[indexPath.row].releaseDate
                    cell.lblRated.text = String(data1[indexPath.row].voteAverage)
                   
                cell.backgroundColor = UIColor.init(hex: "200F37")
                return cell
            }

        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return myTable.frame.height/6
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        let movie = data1[indexPath.row]
        vc.DetailID = movie.id
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }

}
