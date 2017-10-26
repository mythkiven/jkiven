//
//  OperatorsReportSecondPageVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum {
    /**
     *  账单信息
     */
    OperatorsReportDetailTypeBill = 10,
    /**
     *  办理业务
     */
    OperatorsReportDetailTypeOperation = 11,
    /**
     *  网络数据
     */
    OperatorsReportDetailTypeNetwork = 12,//禁掉
    /**
     *  前10通话
     */
    OperatorsReportDetailTypeTenMostCall = 13,
    /**
     *  通话数据
     */
    OperatorsReportDetailTypeCallList =14 ,
    /**
     *  短信
     */
    OperatorsReportDetailTypeMessage =15,
    /**
     *  更多
     */
    OperatorsReportDetailTypeMore =16 ,
    
}OperatorsReportDetailType;

@interface OperatorsReportSecondPageVC : UITableViewController
/**
 *  模块类型
 */
@property (nonatomic, assign) OperatorsReportDetailType itemType;
@property (strong,nonatomic) NSArray      *data;

@end
