//
//  YJCreditViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRecordViewController.h"
#import "YJTopMenuView.h"
#import "YJListBasicVC.h"
#import "YJListStandardVC.h"

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
    return @[@"基础班",@"标准版"];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad{
    
    
    
    [super viewDidLoad];
     self.navigationItem.title = @"报告";
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
    
    [self initView];
    self.view.backgroundColor = RGB_pageBackground;
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = RGB_white;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
  
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
    YJListBasicVC *listBaseVC = [self.childViewControllers firstObject];
    listBaseVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:listBaseVC.view];
    
}

- (void)addChildViewControllers{
    // 基础版
    YJListBasicVC *vc1 = [[YJListBasicVC alloc] init];
    vc1.title = @"基础版";
        vc1.searchType = 0;
    [self addChildViewController:vc1];
    
    // 标准版
    YJListStandardVC *vc2 = [[YJListStandardVC alloc] init];
    vc2.title = @"标准版";
    vc1.searchType = 1;
    [self addChildViewController:vc2];

    
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
