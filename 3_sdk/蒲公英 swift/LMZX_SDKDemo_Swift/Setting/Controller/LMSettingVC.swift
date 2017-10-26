//
//  LMSettingVC.swift
//  
//
//  Created by yj on 2017/4/7.
//
//

import UIKit
private let colorCellId = "colorCellId"
private let statusCellId = "statusCellId"
class LMSettingVC: UITableViewController {

    let lmzxSDK = LMZXSDK()

    fileprivate lazy var styleArray: [[String: Any]] =
        [
            ["title": "Default / LightContent",
             "styles": ["白","黑"]
            ],
            ["title": "选择退出模式",
             "styles": ["查询成功退出","登录成功退出"]
            ]
        ]
    
    var colorArray: [UIColor]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        colorArray = [lmzxSDK.lmzxThemeColor,
        lmzxSDK.lmzxSubmitBtnColor,
        lmzxSDK.lmzxPageBackgroundColor,
        lmzxSDK.lmzxProtocolTextColor,
        lmzxSDK.lmzxTitleColor]
        
        
        
        self.tableView.rowHeight = 44.0
        setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return colorArray?.count ?? 0
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: colorCellId, for: indexPath) as! LMSettingCell
            
            cell.colorView.backgroundColor = colorArray?[indexPath.row];
            switch (indexPath.row) {
            case 0:
                cell.titleLb.text = "导航栏";
                break;
            case 1:
                cell.titleLb.text = "提交按钮";
                break;
            case 2:
                cell.titleLb.text = "页面背景";
                break;
            case 3:
                cell.titleLb.text = "协议文字、动画";
                break;
            case 4:
                cell.titleLb.text = "页面标题、返回按钮";
                break;
            default:
                break;
            }
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: statusCellId, for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = .none
        let dict = styleArray[indexPath.section-1]
        
        let seg = UISegmentedControl(items: dict["styles"] as? [Any])
        seg.selectedSegmentIndex = 0
        seg.isUserInteractionEnabled = false
        cell.accessoryView = seg
        cell.textLabel?.text = dict["title"] as? String
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "颜色搭配";
        } else if (section == 1) {
            return "状态栏样式";
        }
        return "退出模式";
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath) as? LMSettingCell
            
            let colorVc = LMZXColorViewController()

            colorVc.colorBlock = {
                (color) in
                
                self.colorArray?[indexPath.row] = color!
                
                switch (indexPath.row) {
                case 0:
                    self.lmzxSDK.lmzxThemeColor = color;
                    break;
                case 1:
                    self.lmzxSDK.lmzxSubmitBtnColor = color;
                    break;
                case 2:
                    self.lmzxSDK.lmzxPageBackgroundColor = color;
                    break;
                case 3:
                    self.lmzxSDK.lmzxProtocolTextColor = color;
                    break;
                case 4:
                    self.lmzxSDK.lmzxTitleColor = color;
                    break;
                default:
                    break;
                }
                
                self.tableView.reloadData()
            }
            
            colorVc.title =  cell?.titleLb.text
            colorVc.testColor = colorArray?[indexPath.row]
            navigationController?.pushViewController(colorVc, animated: true)
            
        default:
            let cell = tableView.cellForRow(at: indexPath)
            guard let seg = cell?.accessoryView as? UISegmentedControl else {
                return
            }
            
            seg.selectedSegmentIndex = seg.selectedSegmentIndex == 1 ? 0 : 1
            if indexPath.section == 1 {
                lmzxSDK.lmzxStatusBarStyle = seg.selectedSegmentIndex == 0 ? LMZXStatusBarStyleLightContent : LMZXStatusBarStyleDefault
            } else {
                lmzxSDK.lmzxQuitOnSuccess = seg.selectedSegmentIndex == 0 ? true : false
                
            }
            
            
        }
        
        
        
    }




}




extension LMSettingVC {
    func setupUI() {
         navigationItem.title = "设置"
        tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);

        tableView.register(UINib(nibName: "LMSettingCell", bundle: nil), forCellReuseIdentifier: colorCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: statusCellId)
        
    }
    
    
    
    

}
