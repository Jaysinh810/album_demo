//
//  detailVC.swift
//  album_Demo
//
//  Created by Jay on 07/07/24.
//

import UIKit

class detailVC: UIViewController {
    
    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var useridLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIImageView!
    
    var userid: Int?
    var detailid: Int?
    var userTitle: String?
    var userImg: String?
    var favFlag: Bool?
    var userArr = [userModel]()
    
    
    //MARK: ------------------------- VIEWDIDLOAD -------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.userImgView.layer.cornerRadius = self.userImgView.frame.width / 2
        self.userImgView.clipsToBounds = true
        self.userImgView.image = UIImage(systemName: "person.circle")
        
        self.useridLbl.text = "User ID : \(self.userid ?? 0)"
        self.titleLbl.text = "Title : \(self.userTitle ?? "")"
        self.titleLbl.numberOfLines = 0
        
        self.favouriteBtn.image = self.favFlag ?? false ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        print("==> Detail ID", self.detailid)
        self.favouriteBtn.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.favouriteBtn.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    //MARK: ------------------------- IBACTIONS -------------------------
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if self.favouriteBtn.image == UIImage(systemName: "star") {
            self.favouriteBtn.image = UIImage(systemName: "star.fill")
        } else {
            self.favouriteBtn.image = UIImage(systemName: "star")
        }
    }
    
    
}
