//
//  LMHomeVC.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/3/31.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import UIKit
private let cellId = "LMHomeCollectionViewCellId";
private let reusableViewId = "LMCollectionReusableViewId";



class LMHomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let lmSDK = LMZXSDK.initLMZXSDK(withApikey: APIKey, uid: UID, callBackUrl: CALLBACKURL)!
    
//    let lmSDK = LMZXSDK()
    
    
    fileprivate lazy var dataSource: [LMHomeTypeModel]? = {
        () in
        let path = Bundle.main.path(forResource: "homeType", ofType: "plist")
        guard let path1 = path else {return nil}
        let array = NSArray(contentsOfFile: path1)
        guard let array1 = array as? [[String: Any]] else {return nil}
        var modelArray = [LMHomeTypeModel]()
        for item in array1 {
            modelArray.append(LMHomeTypeModel(dict: item))
        }
        return modelArray
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setupUI();
        
        initLMSDK()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension LMHomeVC {
    
    // MARK:- 设置UI
    func setupUI() {
        
        
        collectionView .register(UINib(nibName: "LMHomeCell", bundle: nil), forCellWithReuseIdentifier: cellId);
        
        collectionView.register(UINib(nibName: "LMHomeReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reusableViewId)
        collectionView.showsVerticalScrollIndicator = false;
        
    }
    
    // MARK:- ***初始化SDK***
    func initLMSDK() {
        
        // 测试环境（不设置默认为生成环境）
//        lmSDK.testServiceURL = ""
        
        // 导航条颜色
//        lmSDK.lmzxThemeColor = UIColor.blue
        
        
        //返回按钮文字\图片颜色,标题颜色
        lmSDK.lmzxTitleColor = UIColor.white
        
        
         //查询页面协议文字颜色,和查询动画页面的动画颜色,文字颜色相同
        lmSDK.lmzxProtocolTextColor = UIColor(red: 48/255.0, green: 113/255.0, blue: 242/255.0, alpha: 1.0)//RGB(48, 113, 242)
        
        
        
          //提交按钮颜色
        lmSDK.lmzxSubmitBtnColor = UIColor(red: 57/255.0, green: 179/255.0, blue: 27/255.0, alpha: 1.0)//RGB(57, 179, 27)

        // 页面背景颜色
        lmSDK.lmzxPageBackgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)//RGB(245, 245, 245)
        
        
        //    // 自定义失败时,是否需要退出   默认为NO 不退出
        //    _lmzxSDK.lmzxQuitOnFail = NO;
        // 自定义查询成功时,是否需要退出   默认为 YES  退出
        lmSDK.lmzxQuitOnSuccess = false;
        
        
    }
    
    
    
    
    
}


extension LMHomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let num = dataSource?.count else {return 0}
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let arr = dataSource else {return 0}
        
        return arr[section] .functionModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LMHomeCell
        if let arr = dataSource {
            cell.functionModel = arr[indexPath.section].functionModels[indexPath.item]
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reusableViewId, for: indexPath) as! LMHomeReusableView
        guard let arr = dataSource else {return reusableView}

        reusableView.lineView.backgroundColor = UIColor.colorWithHexColorString(arr[indexPath.section].titleColor)
        reusableView.groupTitleLb.text = arr[indexPath.section].groupTitle
        
        return reusableView
        
    }
    
    
    
}



extension LMHomeVC: UICollectionViewDelegate {
// MARK: -点击查询
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let arr = dataSource else {return}
       
        let functionModel = arr[indexPath.section].functionModels[indexPath.item]
        
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        var functionType: LMZXSDKFunction?
        
        switch functionModel.type {
            case "housefund":
                functionType = LMZXSDKFunctionHousingFund
            
            case "socialsecurity":
                functionType = LMZXSDKFunctionSocialSecurity
            case "mobile":
                functionType = LMZXSDKFunctionMobileCarrie
            case "jd":
                functionType = LMZXSDKFunctionJD
            case "taobao":
                functionType = LMZXSDKFunctionTaoBao
            case "education":
                functionType = LMZXSDKFunctionEducation
            case "credit":
                functionType = LMZXSDKFunctionCentralBank
            case "bill":
                functionType = LMZXSDKFunctionCreditCardBill
            case "ebank":
                functionType = LMZXSDKFunctionEBankBill
            case "autoinsurance":
                functionType = LMZXSDKFunctionAutoinsurance
            default:
                break
        }
        
        if let functionType = functionType {
            
            // MARK: - 服务端加签
            // 方法1
            lmSDK.start(functionType, authCallBack: { (authInfo) in
                
                // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
                let sign = authInfo! + APISECRET
                print("1.sign:\(sign)")
                let ss = sign.SHA1()
                 print("2.ss:\(ss)")
                self.lmSDK.sendReq(withSign: ss)
                
            })
            
            
            
            /*
                //方法2 (加签、结果回调)
                lmSDK.start(functionType, authCallBack: { (authInfo) -> String? in
                    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
                    let sign = authInfo! + APISECRET
                    return sign.SHA1()
                }, resultCallBack: { (code: Int, function: LMZXSDKFunction, obj: Any?, token: String?) in
                    
                    print("code:\(code);function:\(function);obj:\(String(describing: obj));token:\(String(describing: token))")

                })
            
            **/
        }
        
        handleResult(functionModel.type)
       

    }
    
    

    
}

extension LMHomeVC {
    // MARK: - 结果回调
    func handleResult(_ bizType: String) {
        
        lmSDK.lmzxResultBlock = {
            [weak self] (code: Int, function: LMZXSDKFunction, obj: Any?, token: String?) in
            
//            guard let obj = obj as? [String: Any] else {return}
            print("code:\(code);function:\(function);obj:\(String(describing: obj)));token:\(String(describing: token))")
            
            
            
//            展示结果
            let resultVc = LMResultShowVc()
            resultVc.bizType = bizType
            resultVc.token = token
            
            let nav = LMNavigationController(rootViewController: resultVc)
            self?.present(nav, animated: true, completion: nil)
            
                
        }
            
            
            
    }

        
    
}





extension LMHomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: view.frame.width*0.5, height: 65)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 40)
    }
    
}




