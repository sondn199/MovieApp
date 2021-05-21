//
//  FirtVIewWhenclickButtonSearch.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 21/05/2021.
//

import UIKit

class FirtVIewWhenclickButtonSearch: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var myDataSearch : SearchMovieByTitle?
    var listSearch = [Result2]()
    var recent = [String]()
    var myDataGenre : ListGenre?
    var lisGenre = [Genre]()
    var listRecent = [String]()

    @IBOutlet weak var RecentTable: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        RecentTable.largeContentTitle = "Recent"
        RecentTable.isHidden  = true
        RecentTable.backgroundColor = UIColor.init(hex: "17082A")
        view.backgroundColor = UIColor.init(hex: "17082A")
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        searchBar.barTintColor = UIColor.init(hex: "200F37")
        myCollection.largeContentTitle = "Grenre"
        myCollection.backgroundColor = UIColor.init(hex: "17082A")
        myCollection.frame = myCollection.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
        setupData()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        myCollection.reloadData()
    }
    func setupData(){
        DispatchQueue.main.async {
            //self.listRecent.append(Tools.GetObjectUserDefault(key: "search") as! String)
            self.RecentTable.reloadData()
        }
        
        FetchData.shared.getDataListGenre(url: "https://api.themoviedb.org/3/genre/movie/list?api_key=3956f50a726a2f785334c24759b97dc6") { (data, success, error) in
            self.myDataGenre = data
            self.lisGenre = self.myDataGenre?.genres ?? []
            DispatchQueue.main.async {
                self.myCollection.reloadData()
                
            }
        }
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    func setupUI(){
        RecentTable.delegate = self
        RecentTable.dataSource = self
        myCollection.delegate = self
        myCollection.dataSource = self
        searchBar.delegate = self
        myCollection.register(UINib(nibName: "FirstCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        RecentTable.register(UINib(nibName: "RecentCell", bundle: nil), forCellReuseIdentifier: "recenCell")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        myCollection.isHidden = true
        RecentTable.isHidden = false
        

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        var searchItems = searchBar.text?.lowercased() ?? ""
        searchItems = searchItems.replacingOccurrences(of: " ", with: "%20")

        FetchData.shared.getDataSearchMovie(urlString: "https://api.themoviedb.org/3/search/movie?api_key=d9894dad6e8acb82a7c54a35185356bf&query=\(searchItems)&page=1") { (data, true) in
            self.myDataSearch = data
            self.listSearch = self.myDataSearch?.results ?? []
           // print("❤️\(self.listSearch)")
            DispatchQueue.main.async {
                let vc = SearchViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.searchtext = searchItems.replacingOccurrences(of: "%20", with: " ")
                vc.listSearch = self.listSearch
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
                self.myCollection.reloadData()
                Tools.SaveObjectUserDefault(searchItems.replacingOccurrences(of: "%20", with: " "), key: "search")
                vc.recent.append(Tools.GetObjectUserDefault(key: "search") as! String )
               
            }
        }

    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lisGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if lisGenre.count != 0 {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FirstCell
            cell.myLable.text = lisGenre[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.size.width/2 - 10 , height: myCollection.frame.size.height/8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListMovieByGenreView()
        let genre = lisGenre[indexPath.row]
        vc.dataGenre = genre
        vc.id = genre.id
        present(vc, animated: true, completion: nil)
    }

}
extension FirtVIewWhenclickButtonSearch : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return listRecent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRecent = RecentTable.dequeueReusableCell(withIdentifier: "recenCell", for: indexPath) as! RecentCell
        cellRecent.lblHistorySearch.text = listRecent[indexPath.row]
        return cellRecent
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         //   let name = listRecent[indexPath.row]
            listRecent.remove(at: indexPath.row)
            RecentTable.deleteRows(at: [indexPath], with: .automatic)
        }
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.searchtext = listRecent[indexPath.row]
        vc.searchBarSearchButtonClicked(searchBar)
        present(vc, animated: false, completion: nil)
    }
    
}
extension FirtVIewWhenclickButtonSearch: reload {
    func reloaddata(data: [String]) {
        self.listRecent = data
        RecentTable.reloadData()
    }
}
