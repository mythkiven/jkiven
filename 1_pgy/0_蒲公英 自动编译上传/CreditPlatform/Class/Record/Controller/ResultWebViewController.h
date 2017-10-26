//
//  ResultWebViewController.h
//  CreditPlatform
//
//  Created by gyjrong on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//resultVc.url = @"http://192.168.117.239:8185/data/query";

//#define result_web_host_url @" 192.168.117.239:8180/data/query"
@interface ResultWebViewController : UIViewController


@property (strong, nonatomic)  NSString *token;

@property (strong, nonatomic)  NSString *biztype;

@property (strong, nonatomic)  NSString *getResult;

@property (assign, nonatomic)  NSInteger type;

@property (strong, nonatomic)  NSString* url;

@end
