//
//  NewsArticleCell.swift
//  News
//
//  Created by Harsha M G on 16/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsArticleCell: UITableViewCell {

    
    @IBOutlet weak var articleImage: CustomImageView!
   
    @IBOutlet weak var articleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            // Update the cell
         
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
