//
//  AppDelegate.h
//  LMZX_SDK_Demo
//

#import "LMNavigationController.h"

//#import "UIImage+LMZXTint.h"
//
//#import "LMZXDemoAPI.h"
//
//#import "UIBarButtonItem+LMZXExtension.h"
//导航条颜色
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGB_navBar          RGB(48, 113, 242)
@interface LMNavigationController  ()

@end

@implementation LMNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = RGB_navBar;
    self.navigationBar.barTintColor = RGB_navBar;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes =textAttrs;
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setBarTintColor:RGB_navBar];

    
    
}



/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setTintColor:[UIColor whiteColor]];
    [appearance setBarTintColor:RGB_navBar];
    

    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:textAttrs];
    
    
    
    
    
    
    
    
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    
    
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.viewControllers.count >  0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [self backBarButtonItemtarget:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}





- (void)back
{
    [self popViewControllerAnimated:YES];
}
- (UIBarButtonItem *)backBarButtonItemtarget:(id)target action:(SEL)action {
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    
    UIImage *image = [UIImage imageNamed:@"lmzx_back"];

    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setImage:image forState:(UIControlStateHighlighted)];
    
    
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat width = [@"返回" boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + image.size.width;
    
    btn.bounds = CGRectMake(0, 0, width + 5, 44.0);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
    
}


@end
