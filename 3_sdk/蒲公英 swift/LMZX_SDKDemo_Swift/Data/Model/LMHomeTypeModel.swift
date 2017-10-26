//
//  LMHomeTypeModel.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/3/31.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit

class LMFunctionModel: NSObject {
    var icon = ""
    
    var title = ""
    
    var type = ""
    
    override init() {
        
    }
    
    init(dict:[String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}


class LMHomeTypeModel: NSObject {
    var groupTitle = ""
    
    var titleColor = ""
    
    var functions: [[String: Any]]? {
        
        didSet{
            if let functions = functions {
                for dict in functions {
                    
                    functionModels.append(LMFunctionModel(dict: dict))
                }
                
                
            }
            
            
            
        }
        
    }
    
    var functionModels = [LMFunctionModel]()
    
    
    override init() {
        
    }
    
    init(dict:[String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
