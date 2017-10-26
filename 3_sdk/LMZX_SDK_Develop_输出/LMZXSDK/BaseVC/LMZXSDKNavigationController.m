//
//  AppDelegate.h
//  LMZX_SDK_Demo
//

#import "LMZXSDKNavigationController.h"

#import "UIImage+LMZXTint.h"

#import "LMZXDemoAPI.h"

#import "UIBarButtonItem+LMZXExtension.h"

@interface LMZXSDKNavigationController  ()

/**
 *  导航条颜色
 */
@property (nonatomic,strong) UIColor *lmzxThemeColor;

/**
 *  返回按钮文字\图片颜色,标题颜色
 */
@property (nonatomic,strong) UIColor *lmzxTitleColor;

///**
// *  查询页面协议文字颜色,和查询动画页面的动画颜色,文字颜色相同
// */
//@property (nonatomic,strong) UIColor *lmzxProtocolTextColor;
//
///**
// *  提交按钮颜色
// */
//@property (nonatomic,strong) UIColor *lmzxSubmitBtnColor;
//
///**
// *  页面背景颜色
// */
//@property (nonatomic,strong) UIColor *lmzxPageBackgroundColor;


// 字号
@property (strong,nonatomic) UIFont       *lmzxThemeFont;
// 导航条
@property (strong,nonatomic) UINavigationBar *lmzxNavicationBar;
// 返回图片
@property (strong,nonatomic) UIImage      *lmBackImg;
// 返回文字
@property (strong,nonatomic) NSString     *lmBackTxt;

@end

@implementation LMZXSDKNavigationController


// 状态栏 和外部一致
- (UIStatusBarStyle)preferredStatusBarStyle
{
    /*
    UIViewController *v = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (v&&v.childViewControllers.count<1) {
        return [v preferredStatusBarStyle];
    }else if(v){
        return [v.childViewControllers[0] preferredStatusBarStyle];
    }
    [LMZXSDK shared]
     */
    
    if ([LMZXSDK shared].lmzxStatusBarStyle == LMZXStatusBarStyleDefault) {
        return UIStatusBarStyleDefault;
    }
    
    return UIStatusBarStyleLightContent;
}





//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//    NSLog(@"导航栏-%s",__func__);
//    return UIStatusBarAnimationNone;
//}
//- (BOOL)prefersStatusBarHidden
//{
//    NSLog(@"导航栏-%s",__func__);
//    return NO;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    if ([LMZXSDK shared].lmzxThemeColor) {
        _lmzxThemeColor = [LMZXSDK shared].lmzxThemeColor;
    }
    if ([LMZXSDK shared].lmzxTitleColor) {
        _lmzxTitleColor = [LMZXSDK shared].lmzxTitleColor;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    if (!self.lmzxThemeColor){
        self.lmzxThemeColor = LM_RGB(48, 113, 242);
    }
    
    if (!self.lmzxThemeFont) {
        self.lmzxThemeFont = LM_Font(17);
    }
    
    if (self.lmzxNavicationBar) {
        
        self.navigationController.navigationBar.alpha = self.lmzxNavicationBar.alpha;
        self.navigationBar.translucent = self.lmzxNavicationBar.translucent;
        self.navigationBar.tintColor   = self.lmzxNavicationBar.tintColor;
        self.navigationBar.barTintColor = self.lmzxNavicationBar.barTintColor;
        
        
        UINavigationBar *appearance = [UINavigationBar appearance];
        [appearance setBarTintColor:self.lmzxNavicationBar.barTintColor];
        appearance.shadowImage =self.lmzxNavicationBar.shadowImage;
        
        
        return;
    }
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = self.lmzxThemeColor;
    self.navigationBar.barTintColor = self.lmzxThemeColor;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =  self.lmzxTitleColor ? self.lmzxTitleColor:[UIColor whiteColor];
    textAttrs[NSFontAttributeName] = self.lmzxThemeFont;
    self.navigationBar.titleTextAttributes =textAttrs;
    
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 
    [appearance setBarTintColor:self.lmzxThemeColor];
    [appearance setBackgroundImage:[UIImage imageWithColor:[self.lmzxThemeColor colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    appearance.shadowImage =[UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    
    
    
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearanceBar = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrsBar = [NSMutableDictionary dictionary];
    textAttrsBar[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrsBar[NSFontAttributeName] = self.lmzxThemeFont;
    
    [appearanceBar setTitleTextAttributes:textAttrsBar forState:UIControlStateNormal];
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrsBar];
    highTextAttrs[NSForegroundColorAttributeName] = self.lmzxTitleColor ? self.lmzxTitleColor:[UIColor whiteColor];
    [appearanceBar setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.viewControllers.count >  0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}





- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
