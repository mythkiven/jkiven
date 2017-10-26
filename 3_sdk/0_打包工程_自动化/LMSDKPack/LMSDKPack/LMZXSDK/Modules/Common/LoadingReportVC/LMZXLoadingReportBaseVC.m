//
//  JLoadingReportVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXLoadingReportBaseVC.h"
#import "UIBarButtonItem+LMZXExtension.h"

@interface LMZXLoadingReportBaseVC ()<UIAlertViewDelegate>

{
    LMZXLoadingManagerView *_loadingView;
    /// 北京文山
    BOOL _isPresent;
}




@end

@implementation LMZXLoadingReportBaseVC
#pragma mark--懒加载
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


#pragma mark--生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 界面
    [self setupUI];
    
    // 加载数据
    [self loadData];
    
    // 短信验证码回调处理
    [self handleSMS];
    
    
}
// 事都是 present 的
-(BOOL)isPresent{
   
//    //
//    if (self.movingToParentViewController) { // pop: self.movingFromParentViewController
//        return NO;
//    }
//    // push
//    if (self.navigationController.topViewController == self) {
//        return NO;
//    }
    
    // 都不行: self.presentedViewController self.presentedViewController
    
//    // modal
//    if (self.beingPresented) {
//        return YES;
//    }
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) { //push方式
            return NO;
        }
    }else{ //present方式
        return YES;
    }
    
    
    return NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if( _searchType ==LMZXSearchItemTypeOperators && [self isPresent]){
        _isPresent =YES;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(dismiss)];
    }
   
    
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lmzxBaseSearchDataTool stopSearch];

}


#pragma mark--初始化UI
- (void)setupUI {
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
    }
    
    // 初始化界面
    [self.contain addSubview:self.controlView];
    [self.view addSubview:self.contain];
    
}

#pragma mark 根据模块加载数据
-(void)loadData {
    CGFloat loginTime = 15;
    CGFloat checkDataTime = 30;
    CGFloat loginValue = 20;
    
    switch (_searchType) {
        case LMZXSearchItemTypeHousingFund://公积金
        {
            self.title =@"公积金查询";
            loginTime = 10; checkDataTime = 20; loginValue = 20;
            [self loadHouseFund];
            break;
        }case LMZXSearchItemTypeSocialSecurity://社保
        {
            self.title =@"社保查询";
            loginTime = 10; checkDataTime = 20; loginValue = 20;
            [self loadSocialSecturity];
            break;
        }
        case LMZXSearchItemTypeOperators://运营商
        {
            self.title =@"运营商查询";
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                loginTime = 40; checkDataTime = 5; loginValue = 20;
            } else {
                loginTime = 20; checkDataTime = 45; loginValue = 20;
            }
            [self loadMobile];
            break;
        }case LMZXSearchItemTypeE_Commerce://京东24
        {
            self.title =@"京东查询";
            loginTime = 15; checkDataTime = 20; loginValue = 20;
            [self loadJd];
            break;
        }case LMZXSearchItemTypeTaoBao://淘宝25
        {
            self.title =@"淘宝查询";
            loginTime = 15; checkDataTime = 45; loginValue = 20;
            [self loadTaobao];
            break;
        }
        case LMZXSearchItemTypeEducation://学历学籍28
        {
            self.title =@"学历学籍查询";
            loginTime = 5; checkDataTime = 10; loginValue = 20;
            [self loadEducation];
            break;
        }
        case LMZXSearchItemTypeCarSafe://车险
        {
            self.title =@"汽车保险查询";
            loginTime = 15; checkDataTime = 10; loginValue = 20;
            [self loadCarInsurance];
            break;
        }
        case LMZXSearchItemTypeCentralBank://央行征信
        {
            self.title =@"央行征信查询";
            loginTime = 15; checkDataTime = 30; loginValue = 20;
            [self loadCentralBank];
            break;
        }
        case LMZXSearchItemTypeCreditCardBill://信用卡账单 29
        {
            loginTime = 10; checkDataTime = 100; loginValue = 20;
            
            self.lmQueryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypeNormal;
            NSString *title;
            switch (self.creditCardMailType) {
                case LMZXCreditCardBillMailTypeQQ:
                    self.lmQueryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypeQQCredit;
                    title = @"QQ邮箱账单查询";break;
                case LMZXCreditCardBillMailType126:
                    title = @"126邮箱账单查询";break;
                case LMZXCreditCardBillMailType163:
                    title = @"163邮箱账单查询";break;
                case LMZXCreditCardBillMailType139:
                    title = @"139邮箱账单查询";break;
                case LMZXCreditCardBillMailTypesina:
                    title = @"新浪邮箱账单查询";break;
                case LMZXCreditCardBillMailTypealiyun:
                    title = @"阿里云邮箱账单查询";break;
            }
            
            self.title = title;
            [self loadCreditCard];
            break;
        }
        case LMZXSearchItemTypeNetBankBill://网银 32
        {
            self.title =@"网银流水查询";
            [self loadEBank];
            break;
        }
        case LMZXSearchItemTypeMaimai://脉脉26
        {
            loginTime = 10; checkDataTime = 10; loginValue = 20;
            self.title =@"脉脉查询";
            [self loadMaimai];
            break;
        }case LMZXSearchItemTypeLinkedin://领英27
        {
            loginTime = 10; checkDataTime = 30; loginValue = 20;
            self.title =@"领英查询";
            [self loadLinkedin];
            break;
        }
//        case SearchItemTypeLostCredit://失信人 30
//        {
//            loginTime = 10; checkDataTime = 40; loginValue = 20;
//            self.title =@"失信被执行查询";
//            [self loadDishonest];
//            break;
//        }
        case LMZXSearchItemTypeCtrip://携程
        {
            loginTime = 8; checkDataTime = 8; loginValue = 20;
            self.title =@"携程查询";
            [self loadCtrip];
            break;
        }case LMZXSearchItemTypeDiDiTaxi://滴滴出行
        {
            loginTime = 8; checkDataTime = 8; loginValue = 20;
            self.title =@"滴滴出行查询";
            [self loadDidiTaxi];
            break;
        }
        default:
            break;
    }
    __block typeof(self) weakSelf = self;
    self.lmzxBaseSearchDataTool.loginSuccess = ^(id obj){
        if ([(NSString*)obj  isEqualToString:@"0100"]) {
            weakSelf.controlView.isLoginSuccess = YES;
        }
        
    };
    
    self.controlView.LoginTime = loginTime;
    self.controlView.checkDataTime = checkDataTime;
    self.controlView.LoginValue = loginValue;
    
    
    [self.controlView beginAnimationCompleteBlock:nil];
    
    self.lmzxBaseSearchDataTool.currentVC = self;
}




#pragma mark 😊😊😊一期😊😊😊
#pragma mark-- 加载运营商
- (void)loadMobile {
    __weak typeof(self) sself = self;
    // 请求数据
    [self.lmzxBaseSearchDataTool searchMobileDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}

#pragma mark-- 加载淘宝
- (void)loadTaobao {
    __weak typeof(self) sself = self;

    // 请求数据
    [self.lmzxBaseSearchDataTool searchTaobaoDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}
#pragma mark-- 加载京东
- (void)loadJd {
    __weak typeof(self) sself = self;
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchJdDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}
#pragma mark-- 加载学信
- (void)loadEducation {
    __weak typeof(self) sself = self;
    // 请求数据
    [self.lmzxBaseSearchDataTool searchEducationDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
 
}

#pragma mark-- 加载公积金
- (void)loadHouseFund {
    
    __weak typeof(self) sself = self;
    // 请求数据
    [self.lmzxBaseSearchDataTool searchHouseFoundDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}

#pragma mark-- 加载社保
- (void)loadSocialSecturity {
    
    __weak typeof(self) sself = self;
    // 请求数据
    [self.lmzxBaseSearchDataTool searchSocialSecturityDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}

#pragma mark 😊😊😊二期😊😊😊
#pragma mark-- 加载车险
- (void)loadCarInsurance {
    __weak typeof(self) sself = self;
    // 请求数据
    [self.lmzxBaseSearchDataTool searchCarInsuranceDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}
#pragma mark-- 加载央行征信
- (void)loadCentralBank {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchCentralBankDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}

#pragma mark-- 加载信用卡账单
- (void)loadCreditCard {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchCreditCardDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}

#pragma mark-- 加载网银
- (void)loadEBank {
    __weak typeof(self) sself = self;
        // 请求数据
    [self.lmzxBaseSearchDataTool searchEBankDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}
#pragma mark 😊😊😊三期😊😊😊
#pragma mark-- 加载脉脉
- (void)loadMaimai {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchMaimaiDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}
#pragma mark-- 加载领英
- (void)loadLinkedin {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchLinkedinDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}

#pragma mark-- 加载失信
- (void)loadDishonest {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchDishonestDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
    
}

#pragma mark-- 加载携程
- (void)loadCtrip {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchCtripDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}
#pragma mark-- 加载滴滴
- (void)loadDidiTaxi {
    
    __weak typeof(self) sself = self;
    
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchDidiTaxiDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        [sself handleSuccessWithResponse:obj info:dic];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        [sself handleFailureWithError:error code:code info:dic];
    }];
    
}


#pragma mark********短信验证码处理
- (void)handleSMS {
    // 短信回调
    __weak typeof(self) sself = self;
    self.lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
        
        // 验证码:
        if (code == 0) {
            [sself.controlView endAnimation];
            
        }else if (code == 1) {
            [sself.controlView reBeginAnimationCompleteBlock:nil];
        }
    };
}




#pragma mark********成功处理
- (void)handleSuccessWithResponse:(id)obj info:(NSDictionary *)dic {
    NSString *token = dic[@"token"];
    LMZXSDKSearchAction action = [dic[@"code"] intValue];
    
    // 单独处理, 这里只有查询成功才会回调
    // self.controlView.isLoginSuccess = (action == LMZXSDKSearchActionLoginSuccess);
    
    [self.controlView successAnimation:^{
        
        
        if(_isPresent){ /// 北京文山
            [self dismissViewControllerAnimated:YES completion:^{
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(action,[LMZXSDK shared].lmzxFunction, obj, token);
                }else{
                    LMLog(@"立木征信Log:客户需要实现lmzxResultBlock,方可接收回调");
                }
            }];
        }else{
            //页面跳转
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                if ([LMZXSDK shared].lmzxResultBlock) {
                    // 状态码; 功能; 成功信息 ;token
                    [LMZXSDK shared].lmzxResultBlock(action,[LMZXSDK shared].lmzxFunction, obj, token);
                }else{
                    LMLog(@"立木征信Log:客户需要实现lmzxResultBlock,方可接收回调");
                }
            }];
        }
        
    }];
    
    
}
#pragma mark********失败处理
- (void)handleFailureWithError:(NSString *)error code:(NSInteger)code info:(NSDictionary *)dic {
    // 失败结果回调
    NSString *token;
    if (dic) { token = dic[@"token"]; }
    
    if ([LMZXSDK shared].lmzxResultBlock) { // 状态码; 功能; 错误信息 ;token
        [LMZXSDK shared].lmzxResultBlock(code,[LMZXSDK shared].lmzxFunction, error, token?token:@"nil");
    }else{
        LMLog(@"立木征信Log:客户需要实现block(lmzxResultBlock),方可接收回调");
    }
    
    // UI 处理
    [self.controlView endAnimation];
    
    // 改成弹窗的模式
    // [self.view makeToast:error];
    
    __weak typeof(self) weakSelf = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {//如果是iOS8
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:error preferredStyle:UIAlertControllerStyleAlert];
            //这跟 actionSheet有点类似了,因为都是UIAlertController里面的嘛
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // LMLog(@"立木征信错误提示:%@",error);//控制台中打印出输入的内容
                [weakSelf showError];
                
            }];
            //添加按钮
            [alert addAction:ok];
            //以modal的方式来弹出
            [self presentViewController:alert animated:YES completion:^{ }];
        }else{//如果是ios7的话
            UIAlertView*customAlertView;
            if (customAlertView==nil) {
                customAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            }
            [customAlertView setAlertViewStyle:UIAlertViewStyleDefault];
            [customAlertView show];
        }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self showError];
        [self.view endEditing:YES];
    }
}

-(void)showError{
     __weak typeof(self) weakSelf = self;
    // 失败退出 SDK
    if ([LMZXSDK shared].lmzxQuitOnFail ) {
        if (_isPresent) {/// 北京文山
            [weakSelf dismiss];
            //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.3];
        } else {
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        if (_isPresent) { /// 北京文山
            [weakSelf dismiss];
            //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.3];
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
