//
//  ViewController.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 16/04/2021.
//

//
//  HomeVC.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 16/04/2021.
//

import UIKit
import iCarousel
import FSPagerView
import SideMenu

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnTvShow: UIButton!
    @IBOutlet weak var btnMovie: UIButton!
    @IBOutlet weak var myMovie: UITableView!
    @IBOutlet weak var myTVShow: UITableView!
    @IBOutlet weak var MovieView: UIView!
    @IBOutlet weak var TvShowView: UIView!

    
    var menu : SideMenuNavigationController?

    

    override func viewDidLoad() {
        myMovie.separatorStyle = .none
        myTVShow.separatorStyle = .none
        super.viewDidLoad()
        title = "MOVIE"
      //  UINavigationBar.appearance().barTintColor = .blue
        //menu
        menu =  SideMenuNavigationController(rootViewController: MenuList())
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        //
        btnMovie.setImage(UIImage(named: "Vector-1"), for: .normal)
        btnTvShow.setImage(UIImage(named: "Vector-4"), for: .normal)
        btnTvShow.alpha = 0.4
        btnMovie.alpha = 1
        btnMovie.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//        MovieView.layer.borderWidth = 3
//        MovieView.layer.masksToBounds = true
        MovieView.layer.borderColor = UIColor.white.cgColor
        myTVShow.isHidden = true
        view.backgroundColor = UIColor.init(hex: "200F37")
        myMovie.backgroundColor = UIColor.init(hex: "200F37")
        myTVShow.backgroundColor = UIColor.init(hex: "200F37")
        MovieView.backgroundColor = UIColor.init(hex: "200F37")
        TvShowView.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func ClickButtonSearch(_ sender: Any) {
        let vc = FirtVIewWhenclickButtonSearch()
        vc.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
    }
   
    
    
    class MenuList : UITableViewController {
        
        var items = ["Home","Favorite","Setting"]
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.backgroundColor = UIColor.init(hex: "2B1462")
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        override func numberOfSections(in tableView: UITableView) -> Int {
            return items.count
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = items[indexPath.section]
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.layer.cornerRadius = 10
            cell.textLabel?.layer.borderWidth = 2
            cell.textLabel?.alpha = 0.4
            if indexPath.section == 0 {
                cell.textLabel?.alpha = 1
                cell.textLabel?.layer.borderColor = UIColor.init(hex: "#FF8FC6").cgColor
            }
            
            cell.backgroundColor = UIColor.init(hex: "2B1462")
            return cell
        }
       
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerview = UIView()
            headerview.backgroundColor = UIColor.clear
            return headerview
        }
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 25
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            switch indexPath.section {
            case 0:
                cell.textLabel?.alpha = 1
                cell.textLabel?.layer.borderColor = UIColor.init(hex: "#FF8FC6").cgColor
            case 1:
                cell.textLabel?.alpha = 1
                cell.textLabel?.layer.borderColor = UIColor.init(hex: "#FF8FC6").cgColor
            case 2:
                cell.textLabel?.alpha = 1
                cell.textLabel?.layer.borderColor = UIColor.init(hex: "#FF8FC6").cgColor
            default:
                break
            }
        }
    }
    
    @IBAction func didtapMenu(){
        present(menu!, animated: true)
    }

    
    @IBAction func DidTapbuttonMovie(_ sender: Any) {
        btnMovie.setImage(UIImage(named: "Vector-1"), for: .normal)
        btnTvShow.setImage(UIImage(named: "Vector-4"), for: .normal)
        btnTvShow.alpha = 0.4
        btnMovie.alpha = 1
        btnMovie.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btnTvShow.titleLabel?.font = UIFont(name: "Regular", size: 17)
        TvShowView.layer.borderWidth = 0
        MovieView.layer.borderWidth = 3
        MovieView.layer.masksToBounds = true
        MovieView.layer.borderColor = UIColor.white.cgColor
        myMovie.isHidden = false
        myTVShow.isHidden = true
        
    }
    
    @IBAction func DidTapButtonTvShow(_ sender: Any) {
        
        btnMovie.setImage(UIImage(named: "Vector-5"), for: .normal)
        btnTvShow.setImage(UIImage(named: "Vector"), for: .normal)
        btnMovie.alpha = 0.4
        btnTvShow.alpha = 1
        btnTvShow.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btnMovie.titleLabel?.font = UIFont(name: "Regular", size: 17)
        MovieView.layer.borderWidth = 0
        TvShowView.layer.borderWidth = 3
        TvShowView.layer.masksToBounds = true
        TvShowView.layer.borderColor = UIColor.white.cgColor
        myMovie.isHidden = true
        myTVShow.isHidden = false
    }
    func setupUI(){
        myMovie.delegate = self
        myMovie.dataSource = self
        myTVShow.delegate = self
        myTVShow.dataSource = self
        myMovie.register(UINib(nibName: "myTableCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        myMovie.register(UINib(nibName: "CarouCell", bundle: nil), forCellReuseIdentifier: "carouCell")
       // myMovie.register(UINib(nibName: "PagerViewCell", bundle: nil), forCellReuseIdentifier: "pagerCell")
        myTVShow.register(UINib(nibName: "CollectionView0", bundle: nil), forCellReuseIdentifier: "cell0")
        myTVShow.register(UINib(nibName: "TvShowTableCell", bundle: nil), forCellReuseIdentifier: "tvshowCell")
        myTVShow.register(UINib(nibName: "TvGenreCell", bundle: nil), forCellReuseIdentifier: "genreCell")
    }
    func setupData(){
        DispatchQueue.main.async {
            self.myMovie.reloadData()
            
            
        }
         
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.myMovie{
            return 6
        }else if tableView == self.myTVShow{
            return 5
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if tableView == myMovie{
           
            if indexPath.section == 0 {
                let cell = myMovie.dequeueReusableCell(withIdentifier: "carouCell", for: indexPath) as! CarouCell
                return cell
                //            let cell = myMovie.dequeueReusableCell(withIdentifier: "pagerCell", for: indexPath) as! PagerViewCell
                //
                //            return cell
            }
            else {
                let cell = myMovie.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! myTableCell
                
                cell.index = indexPath.section
                cell.setupData()
                cell.setupUI()
                return cell
            }
        }else if tableView == myTVShow {
          
            if indexPath.section == 0 {
                let cell = myTVShow.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! CollectionView0
                cell.setupData()
                cell.setupUI()
                return cell
            }
          else  if indexPath.section == 4{
                let cell = myTVShow.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! TvGenreCell
                return cell
            }else{
                let cell = myTVShow.dequeueReusableCell(withIdentifier: "tvshowCell", for: indexPath) as! TvShowTableCell
                cell.index = indexPath.section
                print("😅\(cell.index)")
                cell.setupData()
                cell.setupUI()
                return cell
            }
        }
        return UITableViewCell()
    }
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.myMovie{
            if indexPath.section == 0 {
                return 370
            }else if indexPath.section == 1{
                return myMovie.frame.size.height/3 - 30
            }else if indexPath.section == 5{
                return myMovie.frame.size.height/4
            }else{
                return myMovie.frame.size.height/3
            }
        }else if tableView == self.myTVShow {
            if indexPath.section == 0 {
                return myTVShow.frame.size.height/4 + 30
            }else if indexPath.section == 4 {
                return myTVShow.frame.size.height
            }else{
                return myTVShow.frame.size.height/4
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == myMovie{
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: myMovie.frame.width, height: 30))
            let button = UIButton(frame: CGRect(x: 10, y: -10, width: 10, height: 20))
            button.setImage(UIImage(named: "Rectangle 1227"), for: .normal)
            let lblHeader = UILabel(frame: CGRect(x: 30, y: -10, width: myView.frame.width/2, height: 20))
            myView.backgroundColor = UIColor.init(hex: "200F37")
            let btnNext = UIButton(frame: CGRect(x: myMovie.frame.size.width - 47 , y: -10, width: 40, height: 20))
            btnNext.setImage(UIImage(named: "Vector-2"), for: .normal)
            lblHeader.textColor = .white
            
            switch section  {
            case 0 :
                lblHeader.isHidden = true
                button.isHidden = true
                btnNext.isHidden = true
            case 1:
                lblHeader.text = "Movie Genre"
                btnNext.addTarget(self, action: #selector(NextGenre), for: .touchUpInside)
            case 2:
                
                lblHeader.text = "Top Rated"
                btnNext.addTarget(self, action: #selector(NextTopRated), for: .touchUpInside)
            case 3:
                lblHeader.text = "Popular"
                btnNext.addTarget(self, action: #selector(NextPopular), for: .touchUpInside)
            case 4:
                lblHeader.text = "Now Playing"
                btnNext.addTarget(self, action: #selector(NextNowLaying), for: .touchUpInside)
            case 5:
                lblHeader.text = "Up Coming"
                btnNext.addTarget(self, action: #selector(NextUpComing), for: .touchUpInside)
            default:
                break
            }
            
            myView.addSubview(button)
            myView.addSubview(lblHeader)
            myView.addSubview(btnNext)
            return myView
        }else if tableView == myTVShow {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: myTVShow.frame.width, height: 30))
            let button = UIButton(frame: CGRect(x: 10, y: -10, width: 10, height: 20))
            button.setImage(UIImage(named: "Rectangle 1227"), for: .normal)
            let lblHeader = UILabel(frame: CGRect(x: 30, y: -10, width: myView.frame.width/2, height: 20))
            myView.backgroundColor = UIColor.init(hex: "200F37")
            let btnNext = UIButton(frame: CGRect(x: myTVShow.frame.size.width - 47 , y: -10, width: 40, height: 20))
            btnNext.setImage(UIImage(named: "Vector-2"), for: .normal)
            lblHeader.textColor = .white
            
            switch section  {
            case 0 :
                lblHeader.text = "Airing Today"
                btnNext.isHidden = false
                button.isHidden = false
            case 1:
                lblHeader.text = "Top Rated"
             //   btnNext.addTarget(self, action: #selector(NextGenre), for: .touchUpInside)
            case 2:
                
                lblHeader.text = "On Air"
              //  btnNext.addTarget(self, action: #selector(NextTopRated), for: .touchUpInside)
            case 3:
                lblHeader.text = "Popular"
              //  btnNext.addTarget(self, action: #selector(NextPopular), for: .touchUpInside)
            case 4:
                lblHeader.text = "Tv Show Genres"
              //  btnNext.addTarget(self, action: #selector(NextNowLaying), for: .touchUpInside)
            
            default:
                break
            }
            
            myView.addSubview(button)
            myView.addSubview(lblHeader)
            myView.addSubview(btnNext)
            return myView
        }
        return UIView()
    }
    @objc func NextGenre(){
        let vc = HomeGenre()
        present(vc, animated: true, completion: nil)
    }
    @objc func NextTopRated(){
        let vc = HomeTopRated()
        present(vc, animated: true, completion: nil)
    }
    @objc func NextPopular(){
        let vc = HomePopular()
        present(vc, animated: true, completion: nil)
    }
    @objc func NextNowLaying(){
        let vc = HomeNowPlaying()
        present(vc, animated: true, completion: nil)
    }
    @objc func NextUpComing(){
        let vc = HomeUpComing()
        present(vc, animated: true, completion: nil)
    }
    
}





