//
//  CastDetailViewController.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 19/05/2021.
//

import UIKit
import Foundation

class CastDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var person_id : Int = 0
    var dataCast : Person?
    var dataMovieByCast : Popular?
    var listMovieByCast = [Result]()
    var listMostSuccessFullMovie = [Result]()
    var dataImage : CastImages?
    var listImageOfCast = [Profile]()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNameFilm.text = "Cast"
        lblNameFilm.textColor = .white
        view.backgroundColor = UIColor.init(hex: "17082A")
        myTable.backgroundColor = UIColor.init(hex: "200F37")
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    func setupData(){
        FetchData.shared.getDataCastDetail(url: "https://api.themoviedb.org/3/person/\(person_id)?api_key=3956f50a726a2f785334c24759b97dc6") { (data, true, error) in
            self.dataCast = data
          //  print("😇\(data)")
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        }
        FetchData.shared.getDataPopular(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6&with_cast=\(person_id)&page=1") { (data, true, error) in
            self.dataMovieByCast = data
            self.listMovieByCast = self.dataMovieByCast?.results ?? []
        //    print("😆\(self.listMovieByCast)")
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
        FetchData.shared.getDataCastImages(url: "https://api.themoviedb.org/3/person/\(person_id)/images?api_key=3956f50a726a2f785334c24759b97dc6") { (data, true, error) in
            self.dataImage = data
         //   print("😅\(self.dataImage)")
            self.listImageOfCast = self.dataImage?.profiles ?? []
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        }
    }
    func setupUI(){
        myTable.delegate = self
        myTable.dataSource = self
        myTable.register(UINib(nibName: "IntroduceOfCastCell", bundle: nil), forCellReuseIdentifier: "cell")
        myTable.register(UINib(nibName: "TableViewInSecssion12", bundle: nil), forCellReuseIdentifier: "cell1")
        myTable.register(UINib(nibName: "ListMovieByGenreCell", bundle: nil), forCellReuseIdentifier: "cell3")
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3{
            return listMovieByCast.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if dataCast != nil{
                
            
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IntroduceOfCastCell
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(dataCast?.profilePath ?? "")"), completed: nil)
            cell.lblNameCast.text = dataCast?.name
            cell.lblAddress.text = dataCast?.placeOfBirth
            cell.lblDateOfBirth.text = dataCast?.birthday
            cell.lblIntruduce.text = dataCast?.biography
            return cell
            }
        }else if indexPath.section == 3 {
            if listMovieByCast.count != 0{
               // print("😆\(listMovieByCast)")
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ListMovieByGenreCell
                cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listMovieByCast[indexPath.row].backdropPath ?? "")"), completed: nil)
                cell.lblNameFilm.text = listMovieByCast[indexPath.row].originalTitle
            cell.lblDate.text = listMovieByCast[indexPath.row].releaseDate
                cell.lblRated.text = String(Double(listMovieByCast[indexPath.row].voteAverage))
            return cell
            }
        }else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewInSecssion12
            cell.index = indexPath.section
            cell.listImage1 = listImageOfCast
            print("🥶\(cell.listImage1)")
            let ss = listMovieByCast.sorted { (s1, s2) -> Bool in
                if s1.voteAverage > s2.voteAverage {
                    return true
                }
                return false
            }
            cell.listMostSuccessFullMovie1.append(contentsOf: ss)
            cell.myCollection.reloadData()
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 300
        }else if indexPath.section == 2 {
            return 200
        }
        return 125
    }

}
