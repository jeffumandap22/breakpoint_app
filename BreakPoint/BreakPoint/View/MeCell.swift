//
//  MeCell.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 16/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

    @IBOutlet weak var postsLabel: UILabel!
    
    func configureCell(post: String) {
        self.postsLabel.text = post
    }
    
}
