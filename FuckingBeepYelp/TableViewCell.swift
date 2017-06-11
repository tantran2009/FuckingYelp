//
//  TableViewCell.swift
//  FuckingBeepYelp
//
//  Created by Taku Tran on 6/7/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var resImage: UIImageView!

    @IBOutlet var resName: UILabel!
    
    @IBOutlet var resRate: UIImageView!
    
    @IBOutlet var resReviews: UILabel!
    
    @IBOutlet var resAddress: UILabel!
    
    @IBOutlet var resType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resImage.layer.cornerRadius = 5;
        resImage.clipsToBounds = true;
        
        resRate.layer.cornerRadius = 5;
        resRate.clipsToBounds = true;
        
        resName.preferredMaxLayoutWidth = resName.frame.size.width;
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        resName.preferredMaxLayoutWidth = resName.frame.size.width;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
