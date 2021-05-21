//
//  PreViewImage.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 20/05/2021.
//

import UIKit

class PreViewImage: UIViewController {
    @IBOutlet weak var ViewContent: UIView!
    @IBOutlet weak var myImage: UIImageView!
    var name : String = ""
    var nameCast : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        //ViewContent.backgroundColor = UIColor.black
        if name != ""{
        myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(name)"), completed: nil)
        }else{
            myImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/original\(nameCast)"), completed: nil)
        }
       
        //zoom image
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlerPinch(sender :)))
        view.addGestureRecognizer(pinch)
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
    

}
