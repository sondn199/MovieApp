//
//  CollectionCellOfSecsion1.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 06/05/2021.
//

import UIKit
import youtube_ios_player_helper

class CollectionCellOfSecsion1: UICollectionViewCell,YTPlayerViewDelegate {
    //var key : String = ""

    @IBOutlet weak var playerView: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        playerView.delegate = self
//        playerView.load(withVideoId: key)
//        print("🥲\(key)")
    }
    @IBAction func btnPlay(_ sender: Any) {
        playerView.playVideo()
    }
    
}
