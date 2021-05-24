//
//  HomeListImage.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class HomeListImage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var listAllImage = [Backdrop]()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.backgroundColor = UIColor.init(hex: "200F37")
        setupData()
        setupUI()
    }
    func setupData(){
        DispatchQueue.main.async {
            self.myCollection.reloadData()
        }
    }
    func setupUI(){
        view.backgroundColor = UIColor.init(hex: "17082A")
        myCollection.delegate = self
        myCollection.dataSource = self
        myCollection.register(UINib(nibName: "CellAllImage", bundle: nil), forCellWithReuseIdentifier: "cell")
        myCollection.collectionViewLayout = generateLayout()
    }

    private func generateLayout() -> UICollectionViewLayout {
        
        
        // Big photos
        let pairMainPhotoSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1.0))
        let pairMainPhotoItem = NSCollectionLayoutItem(layoutSize: pairMainPhotoSize)
        pairMainPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairSmallPhotoSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/2))
        let pairSmallPhotoItem = NSCollectionLayoutItem(layoutSize: pairSmallPhotoSize)
        pairSmallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let stackedSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)), subitem: pairSmallPhotoItem, count: 2)
        
        
        let mainAndSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)), subitems: [stackedSmallPhotoGroup, pairMainPhotoItem])
        
        
        
        
        let smallPhotoSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let smallPhotoItem = NSCollectionLayoutItem(layoutSize: smallPhotoSize)
        smallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let tripleSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitem: smallPhotoItem, count: 3)
        
        let stackedTripleSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)), subitem: tripleSmallPhotoGroup, count: 2)
        
        
        
        let reversedMainAndSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)), subitems: [ pairMainPhotoItem, stackedSmallPhotoGroup])
        
        
        
        
        
        
        let allGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 + 1/4)),
            subitems: [
                mainAndSmallPhotoGroup,
                stackedTripleSmallPhotoGroup,
                reversedMainAndSmallPhotoGroup
            ])
        let section = NSCollectionLayoutSection(group: allGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAllImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellAllImage
        cell.myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(listAllImage[indexPath.row].filePath )"), completed: nil)
        return cell
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PreViewImage()
        vc.modalPresentationStyle = .fullScreen
        let Image = listAllImage[indexPath.row]
        vc.name = Image.filePath
        present(vc, animated: true, completion: nil)
    }

}
