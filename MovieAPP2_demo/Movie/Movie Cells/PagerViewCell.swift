////
////  PagerViewCell.swift
////  MovieAPP2_demo
////
////  Created by ngoc son on 23/05/2021.
////
//
//import UIKit
//import FSPagerView
//
//class PagerViewCell: UITableViewCell,FSPagerViewDelegate,FSPagerViewDataSource {
//    
//    var myDataDiscover : Discover?
//    var listDiscover = [Result3]()
//    var myDataDiscover1 : Discover1?
//    var listDiscorver1 = [Result4]()
//
//    @IBOutlet weak var pagerView: FSPagerView!
//    @IBOutlet weak var pagerControl: FSPageControl!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        contentView.backgroundColor = UIColor.init(hex: "200F37")
//        pagerControl.backgroundColor = UIColor.init(hex: "200F37")
//        setupData()
//        setupUI()
//       
//        //pagerControl.isSelected = true
//        
//    }
//    func setupUI(){
//        pagerView.delegate = self
//        pagerView.dataSource = self
//       
//        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//        pagerView.transformer = FSPagerViewTransformer(type: .coverFlow)
//        pagerView.itemSize = CGSize(width: 220, height: 370)
//        pagerView.interitemSpacing = 100
//        pagerView.isInfinite = true
//        pagerView.automaticSlidingInterval = 2
//        pagerControl.numberOfPages = 6
//        pagerControl.currentPage = 1
//        pagerControl.contentHorizontalAlignment = .center
//        pagerControl.setStrokeColor(UIColor.init(hex: "CBB5FF"), for: .normal)
//        pagerControl.setFillColor(UIColor.init(hex: "CBB5FF"), for: .normal)
//        pagerControl.itemSpacing = 10
//    }
//    func setupData(){
//        FetchData.shared.getDataDiscover(url: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6") { (data, true, error) in
//            if data != nil {
//                self.myDataDiscover = data
//              //  print("😤\(self.myDataDiscover)")
//                self.listDiscover = self.myDataDiscover?.results ?? []
//              //  print("😤\(self.listDiscover)")
//            }else{
//                FetchData.shared.getDataDiscover1(urlString: "https://api.themoviedb.org/3/discover/movie?api_key=3956f50a726a2f785334c24759b97dc6") { (data1, true) in
//                    self.myDataDiscover1 = data1
//                  //  print("😤\(self.myDataDiscover)")
//                    self.listDiscorver1 = self.myDataDiscover1?.results ?? []
//                }
//            }
//            
//            DispatchQueue.main.async {
//                self.pagerView.reloadData()
//            }
//        }
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    func numberOfItems(in pagerView: FSPagerView) -> Int {
//        if listDiscover.count != 0{
//        return listDiscover.count
//        }
//        return listDiscorver1.count
//    }
//    
//    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        if listDiscover.count != 0 {
//        cell.imageView?.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listDiscover[index].backdropPath )"), completed: nil)
//        }else{
//            cell.imageView?.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listDiscorver1[index].backdropPath )"), completed: nil)
//        }
//        return cell
//    }
//    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        let vc = HomeDetailViewController()
//        vc.modalPresentationStyle = .fullScreen
//        let movie = listDiscover[index]
//        vc.DetailID = movie.id
//        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
//    }
//}
