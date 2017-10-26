//
//  ImagePickerVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ImagePickerVC.h"

@interface ImagePickerVC ()

@end

@implementation ImagePickerVC
+ (void)initialize{
    [self setupNavigationBarTheme];
  }
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    
    [appearance setBarTintColor:RGB_navBar];
    
    [appearance setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
//    appearance.shadowImage =[UIImage imageWithColor:RGB(115, 115, 115)];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = Font18;
    [appearance setTitleTextAttributes:textAttrs];
    
    
    
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
