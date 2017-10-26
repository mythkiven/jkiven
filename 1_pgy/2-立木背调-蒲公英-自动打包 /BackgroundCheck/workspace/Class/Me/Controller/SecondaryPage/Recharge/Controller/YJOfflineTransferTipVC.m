//
//  YJOfflineTransferTipVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJOfflineTransferTipVC.h"
#import "YJCommitTransferMsgVC.h"
@interface YJOfflineTransferTipVC ()
@property (weak, nonatomic) IBOutlet UILabel *receiveAccountNameLB;
@property (weak, nonatomic) IBOutlet UILabel *receiveAccountLB;
@property (weak, nonatomic) IBOutlet UILabel *openAccountBankLB;


@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation YJOfflineTransferTipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行转账";
    
    
    [self getBankAccountInfo];
    
    
    self.commitBtn.layer.cornerRadius = 2;
    self.commitBtn.clipsToBounds = YES;
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor  colorWithHexString:@"#39b31b"]] forState:(UIControlStateNormal)];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor  colorWithHexString:@"#39b31b"]] forState:(UIControlStateHighlighted)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
}

- (void)getBankAccountInfo {
    __weak typeof(self) weakSelf = self;
//    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
//    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    NSDictionary *dicParams =@{@"method" : urlJK_companyBankInfo,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"appVersion":ConnectPortVersion_1_0_0};
    
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_companyBankInfo] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {

            dispatch_async(dispatch_get_main_queue(), ^{
//                [YJShortLoadingView yj_hideToastActivityInView:self.view];
                self.receiveAccountNameLB.text = responseObj[@"data"][@"payeeName"];
                self.receiveAccountLB.text = responseObj[@"data"][@"receivableAccount"];
                self.openAccountBankLB.text = responseObj[@"data"][@"accountBank"];
                
            });
            
        }
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            
            [weakSelf.view makeToast:errorInfo];
            [weakSelf performSelector:@selector(outself) withObject:nil afterDelay:2.5];
        });
        
        
    }];
    
    
}

- (IBAction)commitBtnClick {
    YJCommitTransferMsgVC *vc = [[YJCommitTransferMsgVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)contactUs {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-8200-806"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
