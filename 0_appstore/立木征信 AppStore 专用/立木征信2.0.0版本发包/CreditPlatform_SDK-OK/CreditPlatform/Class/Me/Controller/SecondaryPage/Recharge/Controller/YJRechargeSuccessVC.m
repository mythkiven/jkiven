//
//  YJRechargeSuccessVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRechargeSuccessVC.h"

@interface YJRechargeSuccessVC ()
{
    NSTimer *_timer;
    int _time;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@end

@implementation YJRechargeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _time = 3;
    _timeLB.text = @"3秒后自动返回到金额页面";
    
//    if (self.from == YJAlipayFromBalance) { // 从余额入口充值
//        _timeLB.text = [NSString stringWithFormat:@"3秒后自动返回到我的页面"];
//    }else { // 从充值记录入口充值
//        _timeLB.text = [NSString stringWithFormat:@"3秒后自动返回到充值页面"];
//    }
//    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)refreshTime {
    _time --;
    if (self.from == YJAlipayFromBalance) { // 从余额入口充值
        _timeLB.text = [NSString stringWithFormat:@"%d秒后自动返回到我的页面",_time];
    }else { // 从充值记录入口充值
        _timeLB.text = [NSString stringWithFormat:@"%d秒后自动返回到充值列表页面",_time];
    }
    
    
    
    
    if (_time == 0) {
        if (self.from == YJAlipayFromBalance) { // 从余额入口充值
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else { // 从充值记录入口充值
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end
