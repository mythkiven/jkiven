//
//  YJNewFeatureViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJNewFeatureViewController.h"
#import "YJTabBarController.h"
#define NewfeatureImageCount 4

@interface YJNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation YJNewFeatureViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground; 
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    
    
    for (int i = 0; i<NewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
//        if (FourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
//            name = [name stringByAppendingString:@"-568h"];
//        }
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == NewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(NewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = RGB_pageBackground;

}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureImageCount;
    pageControl.centerX = SCREEN_WIDTH * 0.5;
    pageControl.centerY = SCREEN_HEIGHT - iphone56Rate * 60;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = RGB(255, 255, 255); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = RGBA(229, 229, 229, .2); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
    
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
    // 2.添加分享按钮
//    [self setupShareButton:imageView];
}

/**
 *  添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    shareButton.backgroundColor = [UIColor redColor];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    
    // 4.设置间距
    // top left bottom right
    // 内边距 == 自切
    // 被切掉的区域就不能显示内容了
    // contentEdgeInsets : 切掉按钮内部的内容
    // imageEdgeInsets : 切掉按钮内部UIImageView的内容
    // titleEdgeInsets : 切掉按钮内部UILabel的内容
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

/**
 分享
 */
- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
}

/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
//    startButton.layer.cornerRadius = 10;
//    startButton.clipsToBounds = YES;
//    startButton.backgroundColor = [UIColor greenColor];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageNamed:@"icon_start"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"icon_start"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
//    startButton.size = startButton.currentBackgroundImage.size;
    startButton.bounds = CGRectMake(0, 0, 150, 55);
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height - iphone56Rate * 60;
    
    // 4.设置文字
//    [startButton setTitle:@"开启征信" forState:UIControlStateNormal];
//    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  开始微博
 */
- (void)start
{
    
    // 显示主控制器（HMTabBarController）
    YJTabBarController *vc = [[YJTabBarController alloc] init];
    
    
    // 切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
    
    
    if (intPage == NewfeatureImageCount - 1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}




@end
