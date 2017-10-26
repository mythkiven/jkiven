//
//  LMResultShowVc.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/6.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit
import Alamofire

class LMResultShowVc: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var bizType: String?
    var token: String?
    
    var getStatusTime = 0
    
    
    fileprivate lazy var timer: Timer? = {
       () in
        let timer = Timer(timeInterval: 3, target: self, selector: #selector(getResultStatus), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        showResult()
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension LMResultShowVc {
    func setupUI() {
        
        self.textView.text = "数据加载中......."
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(closeResultPage))

    }
    
    func closeResultPage() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LMResultShowVc {
    func showResult() {
        if LMZXSDK.shared().lmzxQuitOnSuccess {
            
            getResult()
            
        } else {
            // 获取状态
            timer?.fire()
            
            
            
        }
        
        
        
    }
    
    
    
    /// 获取状态码
    func getResultStatus() {
        if getStatusTime >= 100 {
            timer?.invalidate()
            timer = nil
        }
        
        getStatusTime += 3
        
        
        let param: [String: Any] = ["method":"api.common.getStatus",
                      "apiKey":LMZXSDK().lmzxApiKey,
                      "version":"1.2.0",
                      "sign":"sign",
                      "accessType":"sdk",
                      "token":token ?? "",
                      "bizType":bizType ?? ""]
        
        LMHttpTool.POST_requestData("https://api.limuzhengxin.com/api/gateway", parameters: param, successOption: { [unowned self] (result) in
             guard let status = result["code"] as? String else { return }
            if status == "0000" { // 进入第三步
                self.removeTimer()
                // 进入第三步结果
                self.getResult()
                
            } else if status == "0100" || status == "" { // 继续循环
                
            } else {
                self.removeTimer()
                
                print(result["msg"] as! String )
            }

            
        }) { [weak self](error) in
            self?.textView.text = "网络请求失败"
            print(error)
            
        }
        
        
        
    }
    
    
    /// 获取结果
    func getResult() {
     
        var param: [String: String] = ["method":"api.common.getResult",
                                    "apiKey":LMZXSDK().lmzxApiKey,
                                    "version":"1.2.0",
                                    "token":token ?? "",
                                    "bizType":bizType ?? ""]
        // 1.参数拼接
        //按照键升序排序
        let array = param.sorted { (v1, v2) -> Bool in
            return v1.0 < v2.0 ? true : false
        }
        var tempArray =  [String]()
        for (key, value) in array {
            tempArray.append("\(key)=\(value)")
        }
        let signStr: String = tempArray.joined(separator: "&") + APISECRET
        // 2.后台加签（本地模拟加签，实际开发APISECRET在服务端）
        param["sign"] = signStr.SHA1()
        
        
        LMHttpTool.POST_requestData("https://api.limuzhengxin.com/api/gateway", parameters: param, successOption: { [unowned self](result) in

            
            self.textView.text = self.changeToJson(info: result)
            
            
            

        }) { [unowned self](error) in
            self.textView.text = error 
        }
        
        
 
        
    }
    
    
    // MARK:- 移除定时器，停止循环请求
    fileprivate func removeTimer() {
        guard timer != nil else { return }
        timer!.invalidate()
        timer = nil
        print("移除定时器")
        
    }
    
    fileprivate func changeToJson(info: Any) -> String{
        //首先判断能不能转换
        guard JSONSerialization.isValidJSONObject(info) else {
            return ""
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: info, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        if let jsonData = jsonData {
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            return str ?? ""
        }else {
            return ""
        }
    }
    
}




