//
//  JLoadingReportVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JLoadingManagerView.h"


// 通用模块

@interface JLoadingReportBaseVC : UIViewController

// 模块，决定加载的内容
@property (nonatomic, assign) SearchItemType  searchType;


@property (strong, nonatomic) UIView        *contain;
@property (strong, nonatomic) NSTimer       *timer;
@property (strong, nonatomic) JLoadingManagerView *controlView;





@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (assign,nonatomic) BOOL   isSCALJL;

//@property (strong,nonatomic) id     obj;
@end
