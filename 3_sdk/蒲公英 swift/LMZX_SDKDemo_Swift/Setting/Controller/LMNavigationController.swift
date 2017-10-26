//
//  LMNavigationController.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/7.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit

class LMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBarTheme()
        
        
        setupBarButtonItemTheme()
        
        
        
        
        
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            // 设置返回按钮
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_back"), style: .done, target: self, action: #selector(back))
            
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func back() {
        self.popViewController(animated: true)
    }



}


extension LMNavigationController {
    
    
    func setupNavigationBarTheme() {
        let appearance = UINavigationBar.appearance()
        //        RGB(48, 113, 242)
        appearance.barTintColor = UIColor(red: 48.0/255.0, green: 113.0/255.0, blue: 242.0/255.0, alpha: 1)
        appearance.alpha = 1.0;
        appearance.isTranslucent = false;
        appearance.tintColor = UIColor(red: 48.0/255.0, green: 113.0/255.0, blue: 242.0/255.0, alpha: 1);
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    func setupBarButtonItemTheme() {
        
        // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
        let appearance = UIBarButtonItem.appearance()
        
        /**设置文字属性**/
        // 设置普通状态的文字属性
        let textAttrs: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        appearance.setTitleTextAttributes(textAttrs, for: .normal)

        
        // 设置高亮状态的文字属性
        var highTextAttrs = textAttrs
        highTextAttrs[NSForegroundColorAttributeName] = UIColor.white
        appearance.setTitleTextAttributes(highTextAttrs, for: .highlighted)
        
        
        
        
    }
}
