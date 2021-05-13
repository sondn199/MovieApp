//
//  HomeDetailViewController.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit

class HomeDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mydataPopular : Result!
    var mydataNowPlaying : Result!
    var DetailID : Int = 0
    var myDataDetail : MovieDetail?
    var myDataDetail2 : MovieDetails?
    var nameFilm : String = ""
    var image : String = ""
    var year : String = ""
    var time : Int = 0
    var overview : String = ""
    var drop_path : String = ""
    var poter_path : String = ""
    var vote_average : Double = 0.0
    var nameTitle : String = ""
    var listCast = [Cast]()
    var thumbnailYTB = [Result1]()
    
    
    
    
   
    @IBOutlet weak var lblNameFilm: UILabel!
    @IBOutlet weak var myTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = UIColor.init(hex: "18072A")
        myTable.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
      
        
        
    }
    func setupUI(){
        myTable.delegate = self
        myTable.dataSource = self
        myTable.register(UINib(nibName: "CellOfSecsion0", bundle: nil), forCellReuseIdentifier: "cell0")
        myTable.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func setupData(){
        let cellDetail = DetailCell()
        FetchData.shared.getDataDetail(url: "https://api.themoviedb.org/3/movie/\(DetailID)?api_key=f64c520a006b21aa8ea0f224091f1bfc&append_to_response=videos,credits") { [self] (data, sucsess, error) in
            if data != nil{
            self.myDataDetail = data
            self.listCast = self.myDataDetail?.credits.cast ?? []
            self.nameFilm = self.myDataDetail?.originalTitle ?? ""
            self.image = self.myDataDetail?.posterPath ?? ""
            self.year = self.myDataDetail?.releaseDate ?? ""
            self.time = self.myDataDetail?.runtime ?? 0
            self.overview = self.myDataDetail?.overview ?? ""
            self.drop_path = self.myDataDetail?.backdropPath ?? ""
            self.poter_path = self.myDataDetail?.posterPath ?? ""
            self.vote_average = self.myDataDetail?.voteAverage ?? 0.0
            self.nameTitle = self.myDataDetail?.title ?? ""
            self.thumbnailYTB = self.myDataDetail?.videos.results ?? []
           
            DispatchQueue.main.async {
                
                cellDetail.listCast1 = self.listCast
                self.myTable.reloadData()
                self.lblNameFilm.text = self.myDataDetail?.originalTitle
                self.lblNameFilm.textColor = .red
                
            }
            } else  {
                FetchData.shared.getDataDetail2(url: "https://api.themoviedb.org/3/movie/\(DetailID)?api_key=f64c520a006b21aa8ea0f224091f1bfc&append_to_response=videos,credits") { (data, sucsess, error) in
                    self.myDataDetail2 = data
                    self.nameFilm = self.myDataDetail2?.originalTitle ?? ""
                    self.listCast = self.myDataDetail2?.credits.cast ?? []
                    self.image = self.myDataDetail2?.posterPath ?? ""
                    self.year = self.myDataDetail2?.releaseDate ?? ""
                    self.time = self.myDataDetail2?.runtime ?? 0
                    self.overview = self.myDataDetail2?.overview ?? ""
                    self.drop_path = self.myDataDetail2?.backdropPath ?? ""
                    self.poter_path = self.myDataDetail2?.posterPath ?? ""
                    self.vote_average = self.myDataDetail2?.voteAverage ?? 0.0
                    self.nameTitle = self.myDataDetail2?.title ?? ""
                    self.thumbnailYTB = self.myDataDetail2?.videos.results ?? []
                    DispatchQueue.main.async {
                        cellDetail.listCast1 = self.listCast
                        self.myTable.reloadData()
                        self.lblNameFilm.text = self.myDataDetail2?.originalTitle
                        self.lblNameFilm.textColor = .red
                        
                    }
                }
            }
            
        }
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! CellOfSecsion0
            cell.lblNameFilm.text = nameFilm
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(image)"), completed: nil)
            cell.lblDateOfYear.text = String(year.suffix(4))
            cell.lblTime.text = String(time/60 ) + "h" + String(time%60) + "mins"
            cell.txtOverView.text = overview
            
            return cell
        }else{
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
            cell.index = indexPath.section
            cell.listCast1 = self.listCast
            cell.backdrop_path = self.drop_path
            cell.poter_path1 = self.poter_path
            cell.nameTitle1 = self.nameTitle
            cell.vote_average1 = self.vote_average
            cell.ThumbnailYoutube = self.thumbnailYTB
            cell.setupData()
            cell.setupUI()
            cell.myCollection.reloadData()
            return cell
        }
          //  return UITableViewCell()
        
    }
    @IBAction func btnBack(_ sender: Any) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 500
        case 1:
            return 200
        case 2:
            return 200
        case 3:
            return 230
        case 4:
            return 200
        case 5:
            return 230
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: myTable.frame.width, height: 200))
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: 300, height: 20))
        title.textColor = .white
        switch section {
        case 1:
            title.text = "Trailers"
            
        case 2:
            title.text = "Cast"
        case 3:
            title.text = "Cusrent Seasion"
        case 4:
            title.text = "Images"
        case 5:
            title.text = "Related"
        default:
            break
        }
        view.addSubview(title)
        return view
    }

}
