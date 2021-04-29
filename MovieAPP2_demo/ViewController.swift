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
    
   
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnTvShow: UIButton!
    @IBOutlet weak var btnMovie: UIButton!
    @IBOutlet weak var myMovie: UITableView!
    @IBOutlet weak var MovieView: UIView!
    @IBOutlet weak var TvShowView: UIView!

    
    var menu : SideMenuNavigationController?

    

    override func viewDidLoad() {
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
        MovieView.layer.borderWidth = 3
        MovieView.layer.masksToBounds = true
        MovieView.layer.borderColor = UIColor.white.cgColor
//        myTVShow.isHidden = true
        view.backgroundColor = UIColor.init(hex: "200F37")
        myMovie.backgroundColor = UIColor.init(hex: "200F37")
        MovieView.backgroundColor = UIColor.init(hex: "200F37")
        TvShowView.backgroundColor = UIColor.init(hex: "200F37")
        
        setupData()
        setupUI()
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
        TvShowView.layer.borderWidth = 0
        MovieView.layer.borderWidth = 3
        MovieView.layer.masksToBounds = true
        MovieView.layer.borderColor = UIColor.white.cgColor
        myMovie.isHidden = false
    }
    
    @IBAction func DidTapButtonTvShow(_ sender: Any) {
        btnMovie.setImage(UIImage(named: "Vector-5"), for: .normal)
        btnTvShow.setImage(UIImage(named: "Vector"), for: .normal)
        btnMovie.alpha = 0.4
        btnTvShow.alpha = 1
        MovieView.layer.borderWidth = 0
        TvShowView.layer.borderWidth = 3
        TvShowView.layer.masksToBounds = true
        TvShowView.layer.borderColor = UIColor.white.cgColor
        myMovie.isHidden = true
    }
    func setupUI(){
        myMovie.delegate = self
        myMovie.dataSource = self
        myMovie.register(UINib(nibName: "myTableCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        myMovie.register(UINib(nibName: "CarouCell", bundle: nil), forCellReuseIdentifier: "carouCell")
        
    }
    func setupData(){
        myMovie.reloadData()
//        myTVShow.reloadData()
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = myMovie.dequeueReusableCell(withIdentifier: "carouCell", for: indexPath) as! CarouCell
            
            return cell
        }
        else {
            let cell = myMovie.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! myTableCell
            
            cell.index = indexPath.section
            cell.setupData()
            cell.setupUI()
           return cell
        }
       
    }
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }else if indexPath.section == 1{
            return myMovie.frame.size.height/3 - 30
        }else if indexPath.section == 5{
            return myMovie.frame.size.height/4
        }else{
            return myMovie.frame.size.height/3
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: myMovie.frame.width, height: 30))
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 20))
        button.setImage(UIImage(named: "Rectangle 1227"), for: .normal)
        let lblHeader = UILabel(frame: CGRect(x: 30, y: 5, width: myView.frame.width/2, height: 30))
        
        let btnNext = UIButton(frame: CGRect(x: myMovie.frame.size.width - 35 , y: 10, width: 20, height: 20))
        btnNext.setImage(UIImage(named: "Vector-2"), for: .normal)
        lblHeader.textColor = .blue
        switch section  {
        case 0 :
            lblHeader.isHidden = true
            button.isHidden = true
            btnNext.isHidden = true
        case 1:
            lblHeader.text = "Movie Genre"
            lblHeader.textColor = .white
        case 2:
            
            lblHeader.text = "Top Rated"
            lblHeader.textColor = .white
        case 3:
            lblHeader.text = "Popular"
            lblHeader.textColor = .white
        case 4:
            lblHeader.text = "Now Playing"
            lblHeader.textColor = .white
        case 5:
            lblHeader.text = "Up Coming"
            lblHeader.textColor = .white
        default:
            break
        }
        myView.addSubview(button)
        myView.addSubview(lblHeader)
        myView.addSubview(btnNext)
        return myView
    }
}





