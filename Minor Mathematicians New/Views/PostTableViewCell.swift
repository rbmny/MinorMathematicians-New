//
//  PostTableViewCell.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 26/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UILabel!

    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post:Post){
        postDate.text = post.createdAt.calenderTimeSinceNow()
        postText.text = post.text
    }
    
}
