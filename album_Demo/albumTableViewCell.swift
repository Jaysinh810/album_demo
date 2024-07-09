//
//  albumTableViewCell.swift
//  album_Demo
//
//  Created by Jay on 07/07/24.
//

import UIKit

class albumTableViewCell: UITableViewCell {

    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var useridLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIImageView!
    
//    var favButtonPressed : (() -> ()) = {}
//    
//    var isFavorite: Bool = false {
//        didSet {
//            let imageName = isFavorite ? "heart.fill" : "heart"
//            self.favouriteBtn.image = UIImage(systemName: imageName)
//        }
//    }
//    
//    var favoriteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.userImgView.layer.cornerRadius = self.userImgView.frame.size.width / 2
        self.userImgView.clipsToBounds = true
        
        
            
        
        
        
        
        

        
        self.titleLbl.numberOfLines = 1
        self.titleLbl.lineBreakMode = .byTruncatingTail
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
//        self.favButtonPressed()
//        
//        if self.favouriteBtn.image == UIImage(systemName: "star") {
//            self.favouriteBtn.image = UIImage(systemName: "star.fill")
//        } else {
//            self.favouriteBtn.image = UIImage(systemName: "star")
//        }
//    }
    
    

}
