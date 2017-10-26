//
//  LMHomeCell.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/3/31.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit

class LMHomeCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    
    var functionModel: LMFunctionModel? {
        didSet{
            if let functionModel = functionModel {
                iconView.image = UIImage(named: functionModel.icon)
                titleLb.text = functionModel.title
            }
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
