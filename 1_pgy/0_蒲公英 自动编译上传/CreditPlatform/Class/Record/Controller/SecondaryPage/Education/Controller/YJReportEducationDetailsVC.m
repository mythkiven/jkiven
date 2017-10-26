//
//  YJReportEducationDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportEducationDetailsVC.h"

#import "EducationView.h"
#import "EducationModel.h"

@interface YJReportEducationDetailsVC ()
{
    CommonSearchDataTool *_commonSearchDataTool;
    EducationModel  *_educationModel;
}
@end

@implementation YJReportEducationDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学历学籍报告";
    self.tableView.frame = CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-10);
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodHouseFundData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commonSearchDataTool removeTimer];
    
}



#pragma  mark 记录 网络
-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_queryEducation,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_0};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
         [YJShortLoadingView yj_hideToastActivityInView:sself.view];
         [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
        MYLog(@"%@",responseObj);
       
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            if (! [responseObj[@"data"][@"data"] isKindOfClass:[NSNull class]]) {
                _educationModel = [EducationModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJShortLoadingView yj_hideToastActivityInView:sself.view];
                    [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                    [sself creatUI];
                });
                
            }
        } else{//异常情况
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }
        
        
    } failure:^(NSError *error) {
        //统一展示，
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:sself.view];
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            [sself.view makeToast:errorInfo];
            [sself jOutSelf];
        });
        
    }];
}
#pragma  mark 首页 网络
- (void)laodHouseFundData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];

    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    
    _commonSearchDataTool.searchType = self.searchType;
    _commonSearchDataTool.method = urlJK_queryEducation;
    
    [_commonSearchDataTool searchDataSuccesssuccess:^(id obj) {
        
        [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            if (! [obj[@"data"][@"data"] isKindOfClass:[NSNull class]]) {
                _educationModel = [EducationModel mj_objectWithKeyValues:obj[@"data"][@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
                    [sself creatUI];
                });
                
            }
            
        } else {
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }
        
       MYLog(@"第三步获取数据-------%@",obj[@"data"][@"data"]);
        
    } failure:^(NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
        });
    }];
    
    _commonSearchDataTool.searchFailure = ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            NSString *errorStr = nil;
            if (error.domain) {
                errorStr = error.domain;
            } else {
                errorStr =errorInfo;
            }
            [sself.view makeToast:errorStr];
            [sself jOutSelf];
        });
        
        
    };
}

#pragma mark --创建UI
- (void)creatUI {
    [self setupHeaderView];
    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    EducationView *top = [EducationView educationViewTop];
    top.xjmodel = _educationModel.SStudentStatusInfo;
    top.xmodel  = _educationModel.EEducationInfo;
    top.frame =CGRectMake(0, 0, SCREEN_WIDTH,  1222);
    
    top.backgroundColor = RGB_pageBackground;
    UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(0, 1222, SCREEN_WIDTH, 50)];
    textL.text = @"没有更多数据了";
    textL.font=Font14;
    textL.textColor = RGB_grayNormalText;
    textL.textAlignment = 1;
    [self.tableView addSubview:textL];
    [self.tableView addSubview:top];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (iPhone6) {
        self.tableView.contentSize =CGSizeMake(0,1222+50);
    }else if (iPhone6P){
        self.tableView.contentSize =CGSizeMake(0,1222+50);
    }else if (iPhone5){
        self.tableView.contentSize =CGSizeMake(0,1222+50);
    }else if (iPhone4s){
        self.tableView.contentSize =CGSizeMake(0,1222+50);
    }
    
}


-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
