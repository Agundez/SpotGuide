//
//  SpotTableViewCell.swift
//  TuristMe
//
//  Created by wizO on 22/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import Alamofire

class SpotTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var commentaryLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
