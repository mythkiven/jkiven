//
//  YJHomeIntroduceVC.m
//  BackgroundCheck
//
//  Created by yj on 2017/9/30.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJHomeGuideContentVC.h"
#import "YJHomeItemModel.h"
#import "YJReportIntroVC.h"
#import "YJReportSampleVC.h"
#import "YJStartSearchViewController.h"

@interface YJHomeGuideContentVC ()
{
    YJReportIntroVC *_introVc;
    YJReportSampleVC *_sampleVc;
    UIButton *_searchBtn;
}

@end

@implementation YJHomeGuideContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self setupNavbar];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupUI {

//    [self.view addSubview:sampleVc.view];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _searchBtn = searchBtn;
    [searchBtn setTitle:@"开始查询" forState:(UIControlStateNormal)];
    [searchBtn setBackgroundImage:[UIImage imageWithColor:RGB(57,179,27)] forState:(UIControlStateNormal)];
    [searchBtn setBackgroundImage:[UIImage imageWithColor:RGB(57,179,27)] forState:(UIControlStateHighlighted)];
    searchBtn.frame = CGRectMake(0, kScreenH-50-64, kScreenW, 50);
    [self.view addSubview:searchBtn];

    [searchBtn addTarget:self action:@selector(startSearchBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    _introVc = [[YJReportIntroVC alloc] init];
    _introVc.introModel = _introModel;
    [self addChildViewController:_introVc];
    _introVc.view.frame = self.view.bounds;
//    [self.view addSubview:_introVc.view];
    [self.view insertSubview:_introVc.view belowSubview:_searchBtn];
    
    
    _sampleVc = [[YJReportSampleVC alloc] init];
    [self addChildViewController:_sampleVc];
    _sampleVc.view.frame = self.view.bounds;
}

/**
 设置导航条
 */
- (void)setupNavbar {
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"报告介绍", @"报告样例"]];
    seg.tintColor = RGB_white;
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segSelect:) forControlEvents:(UIControlEventValueChanged)];
    self.navigationItem.titleView = seg;
    
}

- (void)segSelect:(UISegmentedControl *)seg{
    MYLog(@"%ld",seg.selectedSegmentIndex);

    switch (seg.selectedSegmentIndex) {
        case 0:
            [self removeView:_sampleVc addView:_introVc];
            break;
        case 1:
            [self removeView:_introVc addView:_sampleVc];
            break;
        default:
            break;
    }
}
- (void)removeView:(UIViewController *)removeVC addView:(UIViewController *)addVC {
    if (removeVC.view.superview) {
        addVC.view.alpha = 0;
        [self.view insertSubview:addVC.view belowSubview:_searchBtn];
        [UIView animateWithDuration:0.25 animations:^{
            removeVC.view.alpha = 0;
            addVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            [removeVC.view removeFromSuperview];
        }];
    }
    
}

#pragma 启动查询
- (void)startSearchBtnClick:(UIButton *)sender {
    YJStartSearchViewController *startVc = [[YJStartSearchViewController alloc] init];
    startVc.type = _introModel.searchItemType;
    [self.navigationController pushViewController:startVc animated:YES];
    
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

@end
