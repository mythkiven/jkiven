//
//  ECommerceReportSecondPage.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDReportModel.h"
typedef  enum {
    /**
     *  银行卡信息
     */
    ECommerceReportDetailTypeCard = 10,
    /**
     *  地址信息
     */
    ECommerceReportDetailTypeAddress = 11,
    /**
     *  订单信息
     */
    ECommerceReportDetailTypeOrderList = 12,
    /**
     *  消费统计
     */
    ECommerceReportDetailTypeStatistics =13,
    /**
     *  消费能力柱图
     */
    ECommerceReportDetailTypeCostBarChart =14,
    
}ECommerceReportDetailType;


@interface ECommerceReportSecondPage : UITableViewController
/**
 *  模块类型
 */
@property (nonatomic, assign) ECommerceReportDetailType itemType;
@property (strong,nonatomic) NSArray      *data;
//@property (strong,nonatomic)JDReportModel *model;
@end
