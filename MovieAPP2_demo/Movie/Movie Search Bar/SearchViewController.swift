//
//  SearchViewController.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 17/05/2021.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
   
    var myDataSearch : SearchMovieByTitle?
    var listSearch = [Result2]()
    var recent = [String]()
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var SearchBarController: UISearchBar!
    @IBOutlet weak var SearchTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let searchItems = searchBar.text?.lowercased() ?? ""

        Tools.SaveObjectUserDefault(searchItems, key: "search")
        recent.append(Tools.GetObjectUserDefault(key: "search") as! String)
        print("")
        
        //Cat chuoi truoc dau cach " " va dau cach ""
//        guard let first = searchItems.firstIndex(of: " ") else { return  }
//        let firstPart = searchItems.prefix(upTo: first)
//        print("😂first\(firstPart)")
//        guard let end = searchItems.firstIndex(of: " ") else { return  }
//        var endPart1 = searchItems.suffix(from: end)
//        print("😂end\(endPart1)")
        print("😂\(searchItems)")
        FetchData.shared.getDataSearchMovie(urlString: "https://api.themoviedb.org/3/search/movie?api_key=d9894dad6e8acb82a7c54a35185356bf&query=\(searchItems)&page=1") { (data, true) in
            self.myDataSearch = data
            self.listSearch = self.myDataSearch?.results ?? []
           // print("❤️\(self.listSearch)")
            DispatchQueue.main.async {
                self.SearchTable.reloadData()
            }
        }
    
    }
    
    func setupUI(){
        SearchTable.delegate = self
        SearchTable.dataSource = self
        SearchBarController.showsScopeBar = true
        SearchBarController.delegate = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        SearchTable.register(UINib(nibName: "ListMovieByGenreCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SearchTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListMovieByGenreCell{
            
            if listSearch.count != 0 {
                
                cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listSearch[indexPath.row].backdropPath ?? "")"), completed: nil)
                cell.myImage.layer.cornerRadius = 10
                cell.lblNameFilm.text = listSearch[indexPath.row].originalTitle
                cell.lblDate.text = listSearch[indexPath.row].releaseDate
                cell.lblRated.text = String(listSearch[indexPath.row].voteAverage)
                
                cell.backgroundColor = UIColor.init(hex: "200F37")
                
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
   
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//extension String {
//    private static let slugSafeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-")
//
//    public func convertedToSlug() -> String? {
//        if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
//            let urlComponents = latin.components(separatedBy: String.slugSafeCharacters.inverted)
//            let result = urlComponents.filter { $0 != "" }.joined(separator: "-")
//
//            if result.count > 0 {
//                return result
//            }
//        }
//
//        return nil
//    }
//}
