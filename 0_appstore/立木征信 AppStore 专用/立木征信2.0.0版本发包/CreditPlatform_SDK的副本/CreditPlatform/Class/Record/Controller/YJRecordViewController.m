//
//  YJCreditViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRecordViewController.h"
#import "YJTopMenuView.h"
#import "YJReportHouseFundVC.h" // 公积金
#import "YJReportSocialSecurityVC.h" // 社保
#import "YJReportOperatorsVC.h" // 运营商
#import "YJReportE_CommerceVC.h" // 电商
#import "YJCentralBankVC.h" // 央行
#import "YJEducationVC.h" // 学信
#import "YJTaoBaoVC.h" // 淘宝
#import "YJMaiMaiVC.h" // 脉脉
#import "YJLinkedInVC.h" // 领英
#import "YJCreditEmailBillVC.h" // 信用卡
#import "YJDishonestyVC.h" // 失信
#import "YJCompanyInfoVC.h" // 企业信息
#import "YJCarInsuranceVC.h" // 汽车保险
#import "YJNetBankBillVC.h" // 网银流水
#import "YJDiDiListVC.h" // 滴滴
#import "YJCtripVC.h" // 携程


@interface YJRecordViewController ()<UIScrollViewDelegate,YJTopMenuViewDelegate>
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
{
    CGFloat _startOffsetX;
}

@property (nonatomic, strong) YJTopMenuView *topMenuView;

/**
 *  装有ViewController的ScrollView
 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
/**
 *  当前viewController的索引
 */
@property (nonatomic, assign)NSInteger currentIndex;


@end

@implementation YJRecordViewController

/**
 *  目前四个业务模块
 *
 */
- (NSArray *)menuTitles{
//     return @[@"公积金",@"社保",@"央行征信",@"运营商",@"京东",@"淘宝",@"脉脉",@"领英",@"学历学籍",@"信用卡账单",@"失信被执行"];//,@"企业信用"
//    return @[@"公积金",@"社保",@"央行征信",@"运营商",@"京东",@"信用卡账单",@"淘宝",@"学历学籍",@"领英",@"失信被执行", @"汽车保险", @"网银流水"];//,@"企业信用"
    
   // return @[@"运营商",@"学历学籍",@"淘宝",@"京东",@"信用卡账单",@"央行征信",@"公积金",@"社保",@"领英", @"汽车保险",@"网银流水",@"失信被执行"];//,@"滴滴" ,@"企业信用"
    
    return @[@"运营商",@"京东",@"淘宝",@"失信被执行",@"学历学籍",@"公积金",@"央行征信",@"社保",@"信用卡账单", @"车险",@"领英",@"网银流水",@"滴滴",@"携程"];// ,@"企业信用"
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad{
    
    
    
    [super viewDidLoad];
    if(iOS11){
    }else{
        self.navigationItem.title = @"报告";
    }
    [self setNeedsStatusBarAppearanceUpdate];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showView) name:NSNotificationCenter_ShowMidView object:nil];
//    //这里防止奔溃。过晚的话
//    if (![kUserManagerTool isLogin]) {
//        LoginVC *ll = [[LoginVC alloc]init];
//        ll.isFrom = 89;
//        YJNavigationController *LL = [[YJNavigationController alloc]initWithRootViewController:ll];
//        [self presentViewController:LL animated:YES completion:nil];
//        return;
//    }
    
    [self initTopSearchView];
    [self initView];
    self.view.backgroundColor = RGB_pageBackground;
    
    
}


//-(void)showView {
//    [YJShortLoadingView yj_makeToastActivityInView:self.view];
//    [self performSelector:@selector(showVC) withObject:nil afterDelay:1];
//}
//- (void)showVC{
//    if (self) {
//        [self initTopSearchView];
//        [self initView];
//        self.view.backgroundColor = RGB_pageBackground;
//    }
//    [self.view reloadInputViews];
//    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//
//}

#pragma mark - 顶部搜索框配置
- (void)initTopSearchView{
    // Setup the bar
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = RGB_white;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
//    if (![kUserManagerTool isLogin]) {
//        LoginVC *ll = [[LoginVC alloc]init];
//        ll.isFrom = 89;
//        YJNavigationController *LL = [[YJNavigationController alloc]initWithRootViewController:ll];
//        [self presentViewController:LL animated:YES completion:nil];
//        return;
//    }
}

#pragma mark--联动效果菜单
/**
 *  初始化试图控制器
 */
- (void)initView{
    
    //设置控制器是否自动调整他内部scrollView内边距（一定要设置为NO,否则在导航条显示的时候,scroolView的第一个控制器显示的tableView会有偏差）
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置能够滑动的listTabBar
    self.topMenuView = [[YJTopMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMenuHeight)];
    self.topMenuView.delegate = self;
    self.topMenuView.contentView = self.view;
    if (self.topMenuView.itemsTitle.count) {
        self.topMenuView.itemsTitle = nil;
    }
    self.topMenuView.itemsTitle = [self menuTitles];
    
    [self.view addSubview:self.topMenuView];
    
    //添加能滚动显示ViewController的ScrollView
    CGFloat scroolY = CGRectGetMaxY(self.topMenuView.frame);
    CGFloat scroolH = SCREEN_HEIGHT - scroolY - 44 - 44;
    
    UIScrollView *contentScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroolY, SCREEN_WIDTH, scroolH)];
    contentScroolView.showsHorizontalScrollIndicator = NO;
    contentScroolView.showsVerticalScrollIndicator = NO;
    contentScroolView.contentOffset = CGPointMake(0, -10);
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
    YJCentralBankVC *centralBankVC = [self.childViewControllers firstObject];
    centralBankVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:centralBankVC.view];
   
}

- (void)addChildViewControllers{
    // 运营商
    YJReportOperatorsVC *vc3 = [[YJReportOperatorsVC alloc] init];
    vc3.title = @"运营商";
    vc3.searchType = @"mobile";
    [self addChildViewController:vc3];
    // 京东
    YJReportE_CommerceVC *vc4 = [[YJReportE_CommerceVC alloc] init];
    vc4.title = @"京东";
    vc4.searchType = @"jd";
    [self addChildViewController:vc4];
    // 淘宝
    YJTaoBaoVC *taobao = [[YJTaoBaoVC alloc] init];
    taobao.title = @"淘宝";
    taobao.searchType = @"taobao";
    [self addChildViewController:taobao];
    
    // 失信
    YJDishonestyVC *dishonestyVC = [[YJDishonestyVC alloc] init];
    dishonestyVC.title = @"失信被执行";
    dishonestyVC.searchType = @"shixin";
    [self addChildViewController:dishonestyVC];
    
    // 学历学籍
    YJEducationVC *vc5 = [[YJEducationVC alloc] init];
    vc5.title = @"学历学籍";
    vc5.searchType = @"education";
    [self addChildViewController:vc5];

    
    // 公积金
    YJReportHouseFundVC *vc1 = [[YJReportHouseFundVC alloc] init];
    vc1.title = @"公积金";
    vc1.searchType = @"housefund";
    [self addChildViewController:vc1];
    
    // 央行
    YJCentralBankVC *vc0 = [[YJCentralBankVC alloc] init];
    vc0.title = @"央行征信";
    vc0.searchType = @"credit";
    [self addChildViewController:vc0];
    
    
    // 社保
    YJReportSocialSecurityVC *vc2 = [[YJReportSocialSecurityVC alloc] init];
    vc2.title = @"社保";
    vc2.searchType = @"socialsecurity";
    [self addChildViewController:vc2];
    
    // 信用卡
    YJCreditEmailBillVC *creditEmailBillVC = [[YJCreditEmailBillVC alloc] init];
    creditEmailBillVC.title = @"信用卡账单";
    creditEmailBillVC.searchType = @"bill";
    [self addChildViewController:creditEmailBillVC];
    
//    // 脉脉
//    YJMaiMaiVC *maimai = [[YJMaiMaiVC alloc] init];
//    maimai.title = @"脉脉";
//    maimai.searchType = @"maimai";
//    [self addChildViewController:maimai];
    
    // 汽车保险
    YJCarInsuranceVC *carInsuranceVC = [[YJCarInsuranceVC alloc] init];
    carInsuranceVC.title = @"汽车保险";
    carInsuranceVC.searchType = kBizType_autoinsurance;
    [self addChildViewController:carInsuranceVC];
    
    // 领英
    YJLinkedInVC *linkedIn = [[YJLinkedInVC alloc] init];
    linkedIn.title = @"领英";
    linkedIn.searchType = @"linkedin";
    [self addChildViewController:linkedIn];
    
    // 网银
    YJNetBankBillVC *netBankBillVC = [[YJNetBankBillVC alloc] init];
    netBankBillVC.title = @"汽车保险";
    netBankBillVC.searchType = kBizType_ebank;
    [self addChildViewController:netBankBillVC];
    
    // DIDI
    YJDiDiListVC *didi = [[YJDiDiListVC alloc] init];
    didi.title = @"领英";
    didi.searchType = kBizType_diditaxi;
    [self addChildViewController:didi];
    

    
    // 携程
    YJCtripVC*ctrip= [[YJCtripVC alloc] init];
    ctrip.title = @"携程";
    ctrip.searchType = kBizType_ctrip;
    [self addChildViewController:ctrip];
    
    
   
    // 滴滴
//    YJDiDiListVC *diDiListVC = [[YJDiDiListVC alloc] init];
//    diDiListVC.title = @"滴滴";
//    diDiListVC.searchType = @"";
//    [self addChildViewController:diDiListVC];

    
    
    // 企业信息
    //    YJCompanyInfoVC *companyInfoVC = [[YJCompanyInfoVC alloc] init];
    //    companyInfoVC.title = @"企业信用";
    //    companyInfoVC.searchType = @"education";
    //    [self addChildViewController:companyInfoVC];
    
}



#pragma mark -- scrollView 的代理方法 --

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _startOffsetX = scrollView.contentOffset.x;
    
}
/**
 *  scrollView 滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat progress = 0;
    CGFloat sourceIndex = 0;
    CGFloat targetIndex = 0;
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    int childVcCount = (int)self.childViewControllers.count;
    
    if (currentOffsetX > _startOffsetX) { // 左滑
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        
        sourceIndex = floor(currentOffsetX / scrollViewW);
        targetIndex = sourceIndex + 1;
        
        if (targetIndex >= childVcCount) {
            targetIndex = childVcCount - 1;
        }
        
    } else {
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        targetIndex = floor(currentOffsetX / scrollViewW);
        
        sourceIndex = targetIndex + 1;
        
        if (sourceIndex >= childVcCount) {
            sourceIndex = childVcCount - 1;
        }
        
    }
    //当scrollView滑动超过了屏幕一半时就让它进入下一个界面
    self.currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
    
    
    [_topMenuView setProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    
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
