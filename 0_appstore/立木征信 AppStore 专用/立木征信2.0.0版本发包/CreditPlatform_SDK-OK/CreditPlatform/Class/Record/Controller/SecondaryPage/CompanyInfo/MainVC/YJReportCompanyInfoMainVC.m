//
//  YJReportCompanyInfoDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportCompanyInfoMainVC.h"
#import "YJTopMenuView.h"
#import "ReportCompanyInfoMBusinessPublishVC.h"
#import "ReportCompanyInfoMCompanyPublishVC.h"
#import "ReportCompanyInfoOtherDepartLawAssistVC.h"
@interface YJReportCompanyInfoMainVC ()<UIScrollViewDelegate,YJTopMenuViewDelegate>
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
{
    CommonSearchDataTool *_commonSearchDataTool;
}

@property (nonatomic, strong) YJTopMenuView *topMenuView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, assign)NSInteger currentIndex;


@end

@implementation YJReportCompanyInfoMainVC

- (NSArray *)menuTitles{
    return @[@"工商公示",@"企业公示",@"其他部门公示",@"司法协助公示"];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad{
    
    
    
    [super viewDidLoad];
    self.navigationItem.title = @"企业信用报告";
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    [self initView];
    self.view.backgroundColor = RGB_pageBackground;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = RGB_white;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
}

#pragma mark - 菜单
- (void)initView{
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置能够滑动的listTabBar
    self.topMenuView = [[YJTopMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMenuHeight)];
    self.topMenuView.delegate = self;
    if (self.topMenuView.itemsTitle.count) {
        self.topMenuView.itemsTitle = nil;
    }
    self.topMenuView.itemsTitle = [self menuTitles];
    
    [self.view addSubview:self.topMenuView];
    
    //添加能滚动显示ViewController的ScrollView
    CGFloat scroolY = CGRectGetMaxY(self.topMenuView.frame);
    CGFloat scroolH = SCREEN_HEIGHT - scroolY - 44;
    
    UIScrollView *contentScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroolY, SCREEN_WIDTH, scroolH)];
    contentScroolView.showsHorizontalScrollIndicator = NO;
    contentScroolView.showsVerticalScrollIndicator = NO;
    contentScroolView.contentOffset = CGPointMake(0, -44);
    contentScroolView.delegate = self;
    
    //设置scrollView能够分页
    contentScroolView.pagingEnabled = YES;
    //关闭scrollView的弹簧效果
    contentScroolView.bounces = NO;
    contentScroolView.backgroundColor = RGB_pageBackground;
    
    self.contentScrollView = contentScroolView;
    [self.view addSubview:self.contentScrollView];
    
    //添加子控制器
    [self addChildViewControllers];
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.childViewControllers.count,0);
    
    
    //添加默认显示的控制器
    ReportCompanyInfoMBusinessPublishVC *VC1 = [self.childViewControllers firstObject];
    VC1.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:VC1.view];
    
}

/**
 *  添加子控制器
 */
- (void)addChildViewControllers{
    
    // 工商公示
    ReportCompanyInfoMBusinessPublishVC *vc1 = [[ReportCompanyInfoMBusinessPublishVC alloc] init];
    vc1.title = @"工商公示";
    vc1.type =ReportCompanyInfoTypeBusinessPublish;
    [self addChildViewController:vc1];
    
    // 企业公示
    ReportCompanyInfoMCompanyPublishVC *vc2 = [[ReportCompanyInfoMCompanyPublishVC alloc] init];
    vc2.title = @"企业公示";
    vc2.type =ReportCompanyInfoTypeCompanyPublish;
    [self addChildViewController:vc2];
    
    // 其他部门
    ReportCompanyInfoOtherDepartLawAssistVC *vc3 = [[ReportCompanyInfoOtherDepartLawAssistVC alloc] init];
    vc3.title = @"其他部门";
    vc3.type =ReportCompanyInfoTypeOtherDepartment;
    [self addChildViewController:vc3];
    
    
    // 司法协助
    ReportCompanyInfoOtherDepartLawAssistVC *vc4 = [[ReportCompanyInfoOtherDepartLawAssistVC alloc] init];
    vc4.title = @"司法协助";
    vc4.type =ReportCompanyInfoTypeLawAssist;
    [self addChildViewController:vc4];
    
    
}
#pragma mark -- scrollView 的代理方法 --

/**
 *  scrollView 滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //当scrollView滑动超过了屏幕一半时就让它进入下一个界面
    self.currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
    
}

/**
 *  scrollView 动画滚动结束时调用  只有通过代码（设置contentOfset）使scrollView停止滚动才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    
    self.topMenuView.currentItemIndex = self.currentIndex;
    
    UIViewController *vc = self.childViewControllers[self.currentIndex];
    //如果当前试图控制器的View已经加载过了,就直接返回,不会重新加载了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = scrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
}

/**
 *  这个是由手势导致scrollView滚动结束调用（减速）(不实现这个代理方法用手滑scrollView并不会加载控制器)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -- YJTopMenuViewDelegate的代理方法 --
- (void)topMenuView:(YJTopMenuView *)topMenuView didSelectedItemIndex:(NSInteger)index {
    
    [self.contentScrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}






@end
