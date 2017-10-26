//
//  LMSettingCell.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/7.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit

class LMSettingCell: UITableViewCell {
    @IBOutlet weak var titleLb: UILabel!

    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.borderWidth = 0.5;
        colorView.layer.cornerRadius = 2;
        colorView.layer.borderColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0).cgColor
        
        colorView.clipsToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
