//
//  NewsTableViewCell.swift
//  Live TV
//
//  Created by Fahim Rahman on 23/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var channelNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

