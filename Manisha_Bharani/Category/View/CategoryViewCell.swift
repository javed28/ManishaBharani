//
//  CategoryViewCell.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/8/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    @IBOutlet weak var cuisineImage: UIImageView!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var secBorderView: UIView!
    @IBOutlet weak var secIndicator: UIActivityIndicatorView!
    @IBOutlet weak var secCuisineImage: UIImageView!
    @IBOutlet weak var secCatName: UILabel!
    
    @IBOutlet weak var lblCatCount: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    @IBOutlet weak var seclblCatCount: UILabel!
    @IBOutlet weak var secBottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
