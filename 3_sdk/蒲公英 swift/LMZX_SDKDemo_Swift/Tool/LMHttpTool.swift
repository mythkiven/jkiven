//
//  LMZXHttpTool.swift
//
//  Created by yj on 2017/4/6.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit
import Alamofire

class LMHttpTool {
    
    enum HTTPToolType {
        case post
        case get
    }
    
    
    
    /// get请求
    class func GET_requestData(_ urlString: String, parameters: [String : Any]? = nil, successOption successCallBack:@escaping (_ result: [String : Any])->(), failureOption failureCallBack:@escaping (_ error: String)->()) {
        
        requestData(urlString, type: .get, parameters: parameters, successOption: successCallBack, failureOption: failureCallBack)
        
    }
    
    /// post请求
    class func POST_requestData(_ urlString: String, parameters: [String : Any]? = nil, successOption successCallBack:@escaping (_ result: [String : Any])->(), failureOption failureCallBack:@escaping (_ error: String)->()) {
        
        requestData(urlString, type: .post, parameters: parameters, successOption: successCallBack, failureOption: failureCallBack)
        
    }
    
    
    // MARK:-请求失败回调post/get
    class func requestData(_ urlString: String,type: HTTPToolType,parameters: [String : Any]? = nil, successOption successCallBack:@escaping (_ result: [String : Any])->(), failureOption failureCallBack:@escaping (_ error: String)->()) {
        
        let method = type == .post ? HTTPMethod.post : HTTPMethod.get
        
        // 请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 请求失败处理
            guard let result = response.result.value else {
                print("请求失败：\((response.result.error?.localizedDescription)!)")
                
                failureCallBack((response.result.error?.localizedDescription)!)
                
                return
            }
            // 转字典
            guard let dict = result as? [String : Any] else {
                failureCallBack("查询失败(不是字典类型)")
                return
            }
            
            
            
            
            successCallBack(dict)
            
        }
        
        
        
    }
    
    
    
    
}
