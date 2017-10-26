//
//  YJBaseSettingViewController.h
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YJBaseItem.h"
#import "YJItemGroup.h"
#import "YJArrowItem.h"
#import "YJSearchConditionModel.h"

@interface YJBaseSettingViewController : UITableViewController

@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;

@property (nonatomic, strong) NSMutableArray *dataSource;
/**用于区别轮训时间*/
@property (nonatomic, assign) SearchItemType  searchType;
/** 从动画页面传过来的 数据*/
@property (strong,nonatomic) id     obj;

///**城市code*/
//@property (copy,nonatomic) NSString    *cityCode;
///**账号*/
//@property (copy,nonatomic) NSString    *account;
///**密码*/
//@property (copy,nonatomic) NSString    *passWord;
///**客服密码*/
//@property (copy,nonatomic) NSString    *servicePass;

@end
