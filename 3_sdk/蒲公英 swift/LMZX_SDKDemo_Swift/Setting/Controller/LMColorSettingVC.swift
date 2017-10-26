//
//  LMColorSettingVC.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/7.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit
private let kScreenW = UIScreen.main.bounds.size.width

class LMColorSettingVC: UIViewController {

    
    
    
    fileprivate lazy var alphaView = LMAlphaView(frame: CGRect(x: (kScreenW-250)*0.5, y: 500, width: 250, height: 25))
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
        
        view.addSubview(alphaView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
