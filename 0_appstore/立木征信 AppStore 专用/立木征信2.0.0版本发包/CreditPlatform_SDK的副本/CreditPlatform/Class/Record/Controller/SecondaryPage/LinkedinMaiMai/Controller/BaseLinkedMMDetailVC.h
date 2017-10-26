//
//  BaseLinkedMMDetailVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMainModel.h"
#import "LinkedMainModel.h"

typedef  enum {
    /**
     *  基本信息
     */
    LinkedMMDetailBaseInfo = 10,
    /**
     *  好友信息
     */
    LinkedMMDetailFriendInfo,
    /**
     *  工作经历
     */
    LinkedMMDetailWork,
    /**
     *  教育经历
     */
    LinkedMMDetailEducation,
    
    
}LinkedMMDetailType;



@interface BaseLinkedMMDetailVC : UITableViewController
/**
 *  模块类型
 */
@property (nonatomic, assign) LinkedMMDetailType itemType;

/**
 *  领英 脉脉 类型
 */
@property (nonatomic, assign) SearchItemType  searchType;
/**
 *  数据源
 */
@property (nonatomic,strong) id dataDic;



@property (nonatomic,strong) NSMutableArray * dataList;






@end
