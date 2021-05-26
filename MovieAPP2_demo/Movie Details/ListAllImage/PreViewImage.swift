//
//  PreViewImage.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class PreViewImage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
   var index = 0
    var listImageMovie = [Backdrop]()
    var listImageCast = [Profile]()
    var itemIndex : Int = 0
    
    
    @IBOutlet weak var ViewContent: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupData()
        setupUI()
        ViewContent.backgroundColor = UIColor.black
//        if name != ""{
//        myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(name)"), completed: nil)
//        }else{
//            myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(nameCast)"), completed: nil)
//        }
       
        //zoom image
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlerPinch(sender :)))
        ViewContent.addGestureRecognizer(pinch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myCollection.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
        myCollection.isPagingEnabled = true
    }
    
    
    func setupUI(){
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "PreViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setupData(){
        DispatchQueue.main.async {
            self.myCollection.reloadData()
        }
    }
    @objc func handlerPinch(sender : UIPinchGestureRecognizer ){
        guard  sender.view != nil else {
            return
        }
        if sender.state == .began || sender.state == .changed{
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1
        }
    }


    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listImageMovie.count != 0 {
            return listImageMovie.count
        }
        return listImageCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PreViewCell
        if listImageMovie.count != 0{
          
            cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listImageMovie[indexPath.row].filePath)"), completed: nil)
                }else{
                    
                    cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listImageCast[indexPath.row].filePath)"), completed: nil)
                }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.width, height: myCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}




   
    
    

