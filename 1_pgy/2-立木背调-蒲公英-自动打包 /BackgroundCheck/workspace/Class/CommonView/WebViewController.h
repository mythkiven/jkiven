//
//  StaticWebVew.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic, retain) NSString *viewTitle;
@property (nonatomic, retain) NSString *htmlFile;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *htmlStr;
-(void)refreshWebView;
-(void)loadWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end
