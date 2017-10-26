//
//  JLoadingReportVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JLoadingReportBaseVC.h"


#import "OperatorsDataTool.h"

#import "JPopTextFiledView.h"





// 公积金
#import "YJReportHoseFundDetailsVC.h"
// 社保
#import "YJReportSocialSecurityDetailsVC.h"
// 运营商
#import "OperatorsReportMainVC.h"
// 央行
#import "YJReportCentralBankDetailsVC.h"
// 京东
#import "ECommerceReportMainVC.h"
// 淘宝
#import "YJReportTaoBaoDetailsVC.h"
// 学信
#import "YJReportEducationDetailsVC.h"
// 脉脉 // 领英
#import "ReportLinkedinDetailsVC.h"
 
// 信用卡
#import "YJRepoortCreditEmailBillDetailsVC.h"
// 失信
#import "YJReportDishonestyDetailsVC.h"
// 车险
#import "YJReportCarInsurancTypeVC.h"
// 网银
#import "YJReportNetbankBillDetailsVC.h"
//

@interface JLoadingReportBaseVC ()


@property(nonatomic, strong)   UIView *backView;

@end

@implementation JLoadingReportBaseVC
{
    OperatorsDataTool *_operatorsDataTool;
    JPopTextFiledView *_jPopTextFiledView;
   __block OperatorsReportMainVC *_operatorVC;
    BOOL beginLogin;
    id copySelf;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setInfo];
    
    UIImage *img = [UIImage imageNamed:@"homeLoadingReport_background"];
    [img stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    UIImageView *bg = [[UIImageView alloc]initWithImage:img];
    bg.frame =self.view.frame;
    [self.view addSubview:bg];
   
    
    [self initDefault];
    
    
    // 接收到短信验证码的通知 弹出验证码的框。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessage:) name:NSNotificationCenter_OperationShow_sendMeaasga object:nil];
    
}
#pragma mark 根据模块加载数据
-(void) setInfo{
    switch (_searchType) {
        case SearchItemTypeHousingFund://公积金
        {
            self.title =@"公积金查询";
            break;
        }case SearchItemTypeSocialSecurity://社保
        {
            self.title =@"社保查询";
            break;
        }case SearchItemTypeCentralBank://央行征信
        {
            self.title =@"央行征信查询";
            break;
        }
        case SearchItemTypeOperators://运营商
        {
            self.title =@"运营商查询";
            break;
        }case SearchItemTypeE_Commerce://京东24
        {
            self.title =@"京东查询";
            break;
        }case SearchItemTypeTaoBao://淘宝25
        {
            self.title =@"淘宝查询";
            break;
        }case SearchItemTypeMaimai://脉脉26
        {
            self.title =@"脉脉查询";
            break;
        }case SearchItemTypeLinkedin://领英27
        {
            self.title =@"领英查询";
            break;
        }case SearchItemTypeEducation://学历学籍28
        {
            self.title =@"学历学籍查询";
            break;
        }case SearchItemTypeCreditCardBill://信用卡账单 29
        {
            self.title =@"信用卡账单查询";
            break;
        }case SearchItemTypeLostCredit://失信人 30
        {
            self.title =@"失信被执行查询";
            break;
        }case SearchItemTypeCarSafe://车险 31
        {
            self.title =@"汽车保险查询";
            break;
        }case SearchItemTypeNetBankBill://网银 32
        {
            self.title =@"网银流水查询";
            break;
        }
        default:
            break;
    }
}
#pragma mark 背景cover
-(UIView*)backView{
    
    if (!_backView) {
        _backView = [JFactoryView JCoverViewWithBgColor:RGB_black alpha:0.7];
        _backView.frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT+64);
        [self.navigationController.view addSubview:_backView];
        _backView.hidden =YES;
    }
    return _backView;
}
#pragma mark 加载view
-(void)initDefault{
    _contain = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_contain];
    
    _controlView =  [[JLoadingManagerView alloc]initWithFrame:_contain.frame];
    [_contain addSubview:_controlView];
    
}
#pragma mark 周期
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_operatorsDataTool removeTimer];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_operatorVC) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // 设置线 0.5
//    CGSize naviBarSize =self.navigationController.navigationBar.frame.size;
//    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, naviBarSize.height-.7, naviBarSize.width,0.5)];
//    lineImageView.backgroundColor= [UIColor whiteColor];
//    lineImageView.image= [[UIImage imageWithColor:[RGB_red colorWithAlphaComponent:0]] stretchableImageWithLeftCapWidth:10 topCapHeight:0.5];
//    lineImageView.alpha = 0.4;
//    [self.navigationController.navigationBar addSubview:lineImageView];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    
    
    if (!beginLogin) {
        beginLogin = YES;
        _controlView.title = @"账户登录中";
        [_controlView beginAnimationCompleteBlock:^{ }];
#warning  test
//        [self testAPI];
        [self sendNetwork];
    }
    
}

#pragma mark - 测试API
//-(void)testAPI{
//    
//    [self performSelector:@selector(showMessage: ) withObject:nil afterDelay:9];
//    
//    [self performSelector:@selector(showSuccessStr: ) withObject:nil afterDelay:19];
//    
//    
////    [self performSelector:@selector(showMessage: ) withObject:nil afterDelay:36];
//    
////    [self performSelector:@selector(showSuccessStr: ) withObject:nil afterDelay:15];
//    
//    
////    [self performSelector:@selector(showMessage: ) withObject:nil afterDelay:77];
//    
////    [self performSelector:@selector(showSuccessStr:) withObject:nil afterDelay:82];
//    
////    _operatorVC  = [[OperatorsReportMainVC alloc] init];
////    _operatorVC.obj = nil;
//    
//}


#pragma mark - 逻辑部分
#pragma mark 短信验证码处理
-(void)showMessage:(NSNotification*)noti{
    [_operatorsDataTool removeTimer];
    MYLog(@"+++++++++++++2++++++++++++++++");
    [_controlView endAnimation];
    
    if (!_jPopTextFiledView) {
        MYLog(@"+++++++++++++3++++++++++++++++");
        self.backView.hidden =NO;
        
        CGFloat width = JPWIDTH;
        CGFloat height = JPHEIGHT;
        _jPopTextFiledView = [[JPopTextFiledView alloc]initWithFrame:CGRectMake(15, -height, width, height)];
        [self.navigationController.view addSubview:_jPopTextFiledView];
        [self.navigationController.view bringSubviewToFront:_jPopTextFiledView];
 
        [_jPopTextFiledView.textfile  becomeFirstResponder];
        
        if (_isSCALJL) {
            _jPopTextFiledView.sendMsgType = CommonSendMsgTypeJLDX;
        }
        _jPopTextFiledView.txt  = self.searchConditionModel.account;
        [_jPopTextFiledView show];
        [_jPopTextFiledView.textfile  becomeFirstResponder];
        __block typeof(self) sself =self;
        __block typeof(self.backView) ssbv =self.backView;
        _jPopTextFiledView.clickedBlock=(^(NSString * obj ){
            MYLog(@"+++++++++++++4++++++++++++++++%@",obj);
            [sself nextNet:obj];
            
            ssbv.hidden =YES;
        });
        _jPopTextFiledView.CancleBlock=^(){
            [sself.navigationController popViewControllerAnimated:YES];
            
        };
    }
}
-(void)nextNet:(NSString*)obj{
    [self fromYZMNetwork:obj];
    [_controlView reBeginAnimationCompleteBlock:^{ }];
    _jPopTextFiledView = nil;
}

#pragma mark 错误处理 方法
-(void)showErrorE:(id)error {
    
    NSString *errorStr = nil;
    if ([error  isKindOfClass:[NSError class]]) {
       NSError * er  = (NSError *)error;
        if (er.domain) {
            errorStr = er.domain;
        } else {
            errorStr =errorInfo;
        }
    } else if ([error  isKindOfClass:[NSNotification class]]) {
        NSNotification *er = (NSNotification*)error;
        NSDictionary *dic =er.userInfo;
        errorStr = dic[@"key"];
    }else if ([error  isKindOfClass:[NSString class]]) {
        errorStr = (NSString*)error;
    }
    
    [_controlView endAnimation];
    _controlView.progressLabel.hidden =YES;
    MYLog(@"\\\%@",errorStr);
    [self.view makeToast:errorStr];
    [self jOutSelf];
    
}

#pragma mark 加载成功 数据
-(void)showSuccessStr:(id)obj{
 
    
//    if ([Tool objectForKey:@"zhuanyongde#test"]) {
//        [Tool removeObjectForKey:@"zhuanyongde#test"];
//    }
//    [Tool setObject:[obj mj_JSONData] forKey:@"zhuanyongde#test"];
    
    __block typeof(self) sself = self;
//    copySelf = self;
    [_controlView successAnimation:^{
        
//        [sself pushNextVC:obj];
        [sself pop:obj];
    }];
    
}
-(void)pop:(id)obj{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuanyongde#test" object:obj ];
    
}

#pragma mark  -  网络 首页进入的查询
-(void)sendNetwork{
    
    
    if (_searchType == SearchItemTypeOperators) {
        __block typeof(self) sself = self;
        _operatorsDataTool = [[OperatorsDataTool alloc] init];
        _operatorsDataTool.searchConditionModel = self.searchConditionModel;
        _operatorsDataTool.searchType = self.searchType;
        
        [_operatorsDataTool searchInfo:nil OperatorsDataSuccesssuccess:^(id obj) {
            
            if (obj[@"data"][@"data"]) {
                [sself showSuccessStr:obj];
            } else {
                [sself showErrorE:@"暂无数据"];
            }
            
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [sself showErrorE:error];
                });
            });
        }];
    } else if (_searchType == SearchItemTypeOperators) {
        
    }else {
        
    }
    
    
    
}

#pragma mark  网络 验证码验证
-(void)fromYZMNetwork:(NSString*)txt{
    __block typeof(self) sself = self;
    
    _operatorsDataTool = [[OperatorsDataTool alloc]init];
    _operatorsDataTool.info = txt;
    _operatorsDataTool.searchType = self.searchType;
    [_operatorsDataTool messageInfo:nil OperatorsDataMeaasgasuccess:^(id obj) {
        if (obj[@"data"][@"data"]) {
            [sself showSuccessStr:obj];
        } else {
            [sself showErrorE:@"暂无数据"];
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself showErrorE:error];
        });
        
    }];
}


#pragma mark  - 跳转到下一个页面的逻辑
-(void)pushNextVC:(id)obj{
    
    
    switch (_searchType) {
        case SearchItemTypeHousingFund://公积金
        {
            YJReportHoseFundDetailsVC *reportHoseFundVC = [[YJReportHoseFundDetailsVC alloc] init];
            reportHoseFundVC.obj =  obj;
            [self.navigationController pushViewController:reportHoseFundVC animated:YES];
            
            break;
        }case SearchItemTypeSocialSecurity://社保
        {
            
            break;
        }case SearchItemTypeCentralBank://央行征信
        {
            
            break;
        }
        case SearchItemTypeOperators://运营商
        {
            _operatorVC  = [[OperatorsReportMainVC alloc] init];
            _operatorVC.obj = obj;
            [self.navigationController pushViewController:_operatorVC  animated:YES];
            
            break;
        }case SearchItemTypeE_Commerce://京东24
        {
            
            break;
        }case SearchItemTypeTaoBao://淘宝25
        {
            
            break;
        }case SearchItemTypeMaimai://脉脉26
        {
            
            break;
        }case SearchItemTypeLinkedin://领英27
        {
            
            break;
        }case SearchItemTypeEducation://学历学籍28
        {
            
            break;
        }case SearchItemTypeCreditCardBill://信用卡账单 29
        {
            
            break;
        }case SearchItemTypeLostCredit://失信人 30
        {
            
            break;
        }case SearchItemTypeCarSafe://车险 31
        {
            
            break;
        }case SearchItemTypeNetBankBill://网银 32
        {
            
            break;
        }
        default:
            break;
    }
}


#pragma mark  -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
