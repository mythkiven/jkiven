//
//  JLoadingReportVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMZXPopTextFiledView.h"
#import "LMZXLoadingManagerView.h"
#import "LMZXQueryInfoModel.h"
#import "LMZXBaseViewController.h"
#import "LMZXDemoAPI.h"
#import "UIViewController+LMZXBackButtonHandler.h"

@interface LMZXLoadingReportBaseVC : UIViewController


// 模块，决定加载的内容
@property (nonatomic, assign) SearchItemType  searchType;


/** 所有控制器间传递的查询参数 model */
@property (strong,nonatomic) LMZXQueryInfoModel *lmQueryInfoModel;

@property(nonatomic, strong)   UIView *backView;
@property (strong, nonatomic) UIView        *contain;
@property (strong, nonatomic) NSTimer       *timer;

@property (strong, nonatomic) LMZXLoadingManagerView *controlView;

@property (nonatomic, strong) NSMutableArray *dataSource;


/**
 轮循请求
 */
@property (nonatomic, strong)     LMZXBaseSearchDataTool *lmzxBaseSearchDataTool;



@end
