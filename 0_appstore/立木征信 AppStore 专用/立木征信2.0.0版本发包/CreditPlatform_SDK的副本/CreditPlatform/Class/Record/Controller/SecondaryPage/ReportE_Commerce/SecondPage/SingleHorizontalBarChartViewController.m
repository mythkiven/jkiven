//
//  SingleHorizontalBarChartViewController.m
//  ZFChartView
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SingleHorizontalBarChartViewController.h"
#import "ZFChart.h"
#import "JDReportModel.h"
@interface SingleHorizontalBarChartViewController ()<ZFGenericChartDataSource, ZFHorizontalBarChartDelegate>

@property (nonatomic, strong) ZFHorizontalBarChart * barChart;

@property (nonatomic, assign) CGFloat height;

@end

@implementation SingleHorizontalBarChartViewController

- (void)setUp{
    
//    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
//        //首次进入控制器为横屏时
//        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
//        
//    }else{
//        //首次进入控制器为竖屏时
//        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUp];
    _height = 390;
    self.title = @"消费能力";
    self.view.backgroundColor = RGB_pageBackground;
    UIView*bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 390)];
    bgView.backgroundColor = RGB_white;
    [self.view addSubview:bgView];
    
    UIView *lineUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineUp.backgroundColor = RGB_grayLine;
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(0, 389.5, SCREEN_WIDTH, 0.5)];
    lineDown.backgroundColor = RGB_grayLine;
    [bgView addSubview:lineDown];
    [bgView addSubview:lineUp];
    
    
    self.barChart = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 390)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;

    self.barChart.topicLabel.text = @"统计";
    self.barChart.unit = @"人";
    self.barChart.topicLabel.textColor = RGB_greenBtn;
    self.barChart.isShadow =NO;
   
//    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
//    self.barChart.isResetAxisLineMinValue = YES;
//    self.barChart.isShowSeparate = YES;
//    self.barChart.backgroundColor = ZFPurple;
//    self.barChart.unitColor = ZFWhite;
//    self.barChart.axisColor = ZFWhite;
//    self.barChart.axisLineNameColor = ZFWhite;
//    self.barChart.axisLineValueColor = ZFWhite;
    [bgView addSubview:self.barChart];
    [self.barChart strokePath];
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    NSArray *arr= @[_jdReportModel.spendOrder5000UpCount,
                    _jdReportModel.spendOrder3000To5000Count,
                    _jdReportModel.spendOrder1000To3000Count,
                    _jdReportModel.spendOrder500To1000Count,
                    _jdReportModel.spendOrder200To500Count,
                    _jdReportModel.spendOrder100To200Count,
                    _jdReportModel.spendOrder50To100Count,
                    _jdReportModel.spendOrder0To50Count,@"订单笔数"];
    return arr;
//    return @[@"111",@"112",
//             @"322",@"14",
//             @"511",@"600",
//             @"777",@"8888",
//             @"订单笔数"];
    
//    return @[@"1",@"2",
//             @"",@"0",
//             @"569",@"1",
//             @"0",@"2",
//             @"订单笔数"];
//    return @[@"1",@"2",
//             @"",@"",
//             @"0.8",@"",
//             @"",@"100",
//             @"订单笔数"];
    
    
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ @"5000元以上",@"3000-5000元",
              @"1000-3000元",@"500-1000元",
              @"200-500元", @"100-200元",
              @"50-100元",@"0-50元"
              ,@"订单金额"];
}
// bar 颜色
- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[RGB_greenBtn];
}

//- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
//    NSInteger ll =   SCREEN_WIDTH - 115 -15 -40 -5;
//    return ll;
//}



//- (NSInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
//    return 10;
//}

#pragma mark - ZFHorizontalBarChartDelegate
// bar横条 高度
- (CGFloat)barHeightInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
    return 15.f;
}
// bar横条组间距
- (CGFloat)paddingForGroupsInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
    return 25.f;
}

// bar 前方的文本颜色
- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
    return RGB_greenBtn;
}


#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}

@end





