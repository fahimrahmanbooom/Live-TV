//
//  CartoonTableViewCell.swift
//  Live TV
//
//  Created by Fahim Rahman on 23/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

final class CartoonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customContentView: UIView!
    
    @IBOutlet weak var channelImageView: UIImageView!
    
    @IBOutlet weak var channelNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customContentView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
