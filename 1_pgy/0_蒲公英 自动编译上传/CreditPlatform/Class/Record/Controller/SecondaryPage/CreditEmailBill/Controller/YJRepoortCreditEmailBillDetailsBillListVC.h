//
//  YJRepoortCreditEmailBillDetailsBillListVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reportCreditBillModel.h"

typedef  enum { //
    /** 月份
     */
    RepoortCreditEmailBillDetailsTypeMonth = 0 ,
    /** 分期
     */
    RepoortCreditEmailBillDetailsTypeEver,
    
    
}RepoortCreditEmailBillDetailsType;


@interface YJRepoortCreditEmailBillDetailsBillListVC : UITableViewController

@property (assign,nonatomic) RepoortCreditEmailBillDetailsType  detailType;

// 月份数据

@property (strong,nonatomic) reportCreditBillChangeInfo      *reportCreditBillChangeInfo;
//// 账单的全部信息，用于展示顶部
//@property (strong,nonatomic) reportCreditBillBills      *model;
//// 账户变动信息，用于展示顶部
//@property (nonatomic,strong) reportCreditBillAccountChangeInfos * ChangeInfos;
//// 账单明细
//@property (nonatomic,strong) NSArray * dataDetails;



// 分期数据
@property (nonatomic,strong) NSArray * fenqiData;



@end
