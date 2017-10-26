//
//  BaseViewController.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/13.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXBaseViewController.h"
#import "UIImage+LMZXTint.h"
#import "UIBarButtonItem+LMZXExtension.h"
@interface LMZXBaseViewController ()

@end

@implementation LMZXBaseViewController

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicatorView.frame = self.view.bounds;
        _activityIndicatorView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0  blue:199/255.0  alpha:0.3];
        [self.view addSubview:self.activityIndicatorView];
        
        //        _activityIndicatorView.layer.cornerRadius = 5;
        //        _activityIndicatorView.clipsToBounds = YES;
        
    }
    return _activityIndicatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupThemeColor];
    
}

// 设置控制器属性
-(void)setupThemeColor {
    LMZXSDK *lmsdk = [LMZXSDK shared];
    // 主题/导航条颜色
    self.lmzxThemeColor = lmsdk.lmzxThemeColor;
    // titile 颜色
    self.lmzxTitleColor = lmsdk.lmzxTitleColor;
    // 协议文字颜色
    self.lmzxProtocolTextColor = lmsdk.lmzxProtocolTextColor;
    // 提交按钮颜色
    self.lmzxSubmitBtnColor = lmsdk.lmzxSubmitBtnColor;
    // 页面背景色
    self.lmzxPageBackgroundColor =  lmsdk.lmzxPageBackgroundColor;
    
    // 协议
    self.lmzxProtocolUrl = lmsdk.lmzxProtocolUrl;
    self.lmzxProtocolTitle = lmsdk.lmzxProtocolTitle;
    // 返回按钮
    //    self.lmBackImg = lmsdk.lmzxBackImg;
    //    self.lmBackTxt = lmsdk.lmzxBackTxt;
    
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置页面背景色
    self.view.backgroundColor = self.lmzxPageBackgroundColor?self.lmzxPageBackgroundColor:[UIColor whiteColor];
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
    // dfavsv
//    if ([LMZXSDK shared].lmzxQuitOnSuccess && _bo) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
     
    
}




- (void)back{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    
    
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
