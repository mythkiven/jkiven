//
//  LMAlphaView.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/7.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit

private let kSliderLabelWH: CGFloat = 25.0
class LMAlphaView: UIView {

    
    
//    var changeAlpha:((_ alpha: CGFloat)->())
    
    
    fileprivate lazy var moveView: UIImageView = {
        ()  in
        
        let imgView = UIImageView(image: UIImage(named: "theme_label"))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer( UIPanGestureRecognizer(target: self, action: #selector(moveLB)))
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension LMAlphaView {
    func setAlphaTo1() {
        moveView.frame.origin.x = frame.width-kSliderLabelWH
    }
    
}


extension LMAlphaView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.clear
        
        let lb = UILabel(frame: CGRect(x: 0, y: -15, width: 50, height: 20))
        lb.text = "Opacity"
        lb.font = UIFont.systemFont(ofSize: 14)
        addSubview(lb)
        
        let line = UIView(frame: CGRect(x: 0, y: (frame.height-10)*0.5, width: frame.width, height: 10))
        line.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
        line.layer.cornerRadius = 1
        line.clipsToBounds = true
        addSubview(line)
        
        
        moveView.frame = CGRect(x: frame.width-kSliderLabelWH, y: 0, width: kSliderLabelWH, height: kSliderLabelWH)
        addSubview(moveView)
        
        
    }
    
    
    
    @objc fileprivate func moveLB(_ pan: UIPanGestureRecognizer) {
        let transtionP = pan.translation(in: pan.view)
        pan.view?.frame.origin.x = transtionP.x
        
        if (pan.view?.frame.origin.x)! < CGFloat(0) {
            pan.view?.frame.origin.x = 0
        }
        
        if (pan.view?.frame.origin.x)! >= frame.width-kSliderLabelWH {
            pan.view?.frame.origin.x = frame.width-kSliderLabelWH
        }
        
        
        
//        changeAlpha((pan.view?.frame.origin.x)!/(frame.width-kSliderLabelWH))
//        if changeAlpha != nil {
//            changeAlpha((pan.view?.frame.origin.x)!/(frame.width-kSliderLabelWH))
//        }
        

        
    }
    
}
