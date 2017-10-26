//
//  JLoadingReportVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXLoadingReportBaseVC.h"


@interface LMZXLoadingReportBaseVC ()

{
    LMZXLoadingManagerView *_loadingView;
}




@end

@implementation LMZXLoadingReportBaseVC
//{
//    
////    LMZXPopTextFiledView *_jPopTextFiledView;
////    LMZXBaseSearchDataTool *_lmzxBaseSearchDataTool;
////    BOOL beginLogin;
////    BOOL _searchSuccess;
////    BOOL _isSettingUI;
//}
- (UIView *)contain {
    if (!_contain) {
        _contain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_WIDTH)];
        _contain.backgroundColor = [UIColor clearColor];
        _controlView.backgroundColor = [UIColor clearColor];
    }
    return _contain;
}

- (LMZXLoadingManagerView *)controlView {
    if (!_controlView) {
        _controlView = [[LMZXLoadingManagerView alloc] initWithFrame:self.contain.frame];
    }
    return _controlView;
}

- (LMZXBaseSearchDataTool *)lmzxBaseSearchDataTool {
    if (!_lmzxBaseSearchDataTool) {
        _lmzxBaseSearchDataTool = [[LMZXBaseSearchDataTool alloc] init];
    }
    return _lmzxBaseSearchDataTool;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
    }
    
    
    
    
    // 初始化界面
    [self initDefault];
    
    
}

#pragma mark -  创建 View
-(void)initDefault{
    [self.contain addSubview:self.controlView];
    [self.view addSubview:self.contain];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.lmzxBaseSearchDataTool stopSearch];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}



#pragma mark-- 加载运营商
- (void)loadMobile {
    
    
    
}

#pragma mark-- 加载淘宝
- (void)loadTaobao {
    
    
    
}
#pragma mark-- 加载京东
- (void)loadJd {
    
    
    
}
#pragma mark-- 加载学信
- (void)loadEducation {
    
    
    
}


#pragma mark-- 加载




//
////#pragma mark -  创建 View
////
////#pragma mark 根据模块加载数据
////-(void) setInfo {
////    switch (_searchType) {
////        case SearchItemTypeHousingFund://公积金
////        {
////            self.title =@"公积金查询";
////            break;
////        }case SearchItemTypeSocialSecurity://社保
////        {
////            self.title =@"社保查询";
////            break;
////        }case SearchItemTypeCentralBank://央行征信
////        {
////            self.title =@"央行征信查询";
////            break;
////        }
////        case SearchItemTypeOperators://运营商
////        {
////            self.title =@"运营商查询";
////            break;
////        }case SearchItemTypeE_Commerce://京东24
////        {
////            self.title =@"京东查询";
////            break;
////        }case SearchItemTypeTaoBao://淘宝25
////        {
////            self.title =@"淘宝查询";
////            break;
////        }case SearchItemTypeMaimai://脉脉26
////        {
////            self.title =@"脉脉查询";
////            break;
////        }case SearchItemTypeLinkedin://领英27
////        {
////            self.title =@"领英查询";
////            break;
////        }case SearchItemTypeEducation://学历学籍28
////        {
////            self.title =@"学历学籍查询";
////            break;
////        }case SearchItemTypeCreditCardBill://信用卡账单 29
////        {
////            self.title =@"信用卡账单查询";
////            break;
////        }case SearchItemTypeLostCredit://失信人 30
////        {
////            self.title =@"失信被执行查询";
////            break;
////        }case SearchItemTypeCarSafe://车险 31
////        {
////            self.title =@"汽车保险查询";
////            break;
////        }case SearchItemTypeNetBankBill://网银 32
////        {
////            self.title =@"网银流水查询";
////            break;
////        }
////        default:
////            break;
////    }
////}
//
//#pragma mark -  创建 View
//-(void)initDefault{
//    self.contain = [[UIView alloc] initWithFrame:CGRectMake(0,0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)];
//    [self.view addSubview:self.contain];
//    
//    self.controlView =  [[LMZXLoadingManagerView alloc]initWithFrame:self.contain.frame];
//    [self.contain addSubview:self.controlView];
//    
//}
//
//#pragma mark -  网络轮训查询
//
//-(void)sendNetwork{
//    
//    _lmzxBaseSearchDataTool=  [[LMZXBaseSearchDataTool  alloc] init];
//    
//    __block typeof(self) sself = self;
//    _lmzxBaseSearchDataTool.queryInfoModel = self.lmQueryInfoModel;
//    
//    // 短信回调
//    _lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
//        
//        // 验证码:
//        if (code == 0) {
//            [self.controlView endAnimation];
//            
//        }else if (code == 1) {
//            [self.controlView reBeginAnimationCompleteBlock:^{
//                
//            }];
//            
//        }
//    };
//    
//    
//    [_lmzxBaseSearchDataTool searchMobileDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj,NSDictionary *dic) {
//        LMLog(@"运营商查询成功啦,这里是提示");
//        
//        _searchSuccess = YES;
//        [self.controlView successAnimation:^{ // 动画结束后回调 结果
//            
//            if ([LMZXSDK shared].lmzxResultBlock) {
//                NSString *taskID = @"" ;
//                if (dic) { taskID = dic[@"taskID"]; }
//                [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionMobileCarrie, obj, taskID);
//            }
//            
//            [sself jOutSelf];
//        }];
//    } failure:^(NSString*error,NSInteger code,NSDictionary *dic) {
//        [sself.view makeToast:error];
//        
//        NSString *taskID = @"" ;
//        if (dic) { taskID = dic[@"taskID"]; }
//        if ([LMZXSDK shared].lmzxResultBlock) {
//            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionMobileCarrie, @"nil", taskID);
//        }
//        
//        [sself jOutSelf];
//    }];
//    
//}



#pragma mark  - 其他
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
