//
//  YJProtocolVC.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJProtocolVC.h"
#import <WebKit/WebKit.h>
@interface YJProtocolVC ()
{
//    WKWebView *_webView;
    UIWebView *_webView;

}
@end

@implementation YJProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"授权协议";
//    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"protocol" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
    
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
