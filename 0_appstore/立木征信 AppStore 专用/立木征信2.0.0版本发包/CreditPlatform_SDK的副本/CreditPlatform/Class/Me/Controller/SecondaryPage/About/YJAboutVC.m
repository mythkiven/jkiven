//
//  YJAboutVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJAboutVC.h"
#import <MessageUI/MessageUI.h>
#import "YJMeCell.h"
#import <StoreKit/StoreKit.h>
@interface YJAboutVC ()<MFMailComposeViewControllerDelegate, SKStoreProductViewControllerDelegate>

@end

@implementation YJAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 45;
    [self setupHeaderView];
    [self creatgroup0];
//    [self creatgroup1];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupHeaderView  {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = RGB_pageBackground;
    bgView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    CGFloat imgW = 60;
    CGFloat imgH = 90;
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = RGB_pageBackground;
    iconView.frame = CGRectMake((SCREEN_WIDTH-imgW)*0.5, 38, imgW, imgH);
    //    iconView.center = bgView.center;
    iconView.image = [UIImage imageNamed:@"me_icon_logo"];
    [bgView addSubview:iconView];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text =  @"立木征信";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.frame =CGRectMake(0, CGRectGetMaxY(iconView.frame)+10, SCREEN_WIDTH, 21);
    lb.textColor = RGB_black;
    lb.font = Font17;
    [bgView addSubview:lb];
    
    
    UILabel *versionLb = [[UILabel alloc] init];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    versionLb.text =  [NSString stringWithFormat:@"v%@",version];
    versionLb.textAlignment = NSTextAlignmentCenter;
    versionLb.frame =CGRectMake(0, CGRectGetMaxY(lb.frame)+2, SCREEN_WIDTH, 17);
    versionLb.textColor = RGB_grayNormalText;
    versionLb.font = Font15;
    [bgView addSubview:versionLb];
    self.tableView.tableHeaderView = bgView;
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJBaseItem *item0 = [YJBaseItem itemWithTitle:@"联系电话" subTitle:@"400-8200-806"];
//    YJBaseItem *item0 = [YJArrowItem itemWithIcon:@"me_icon_contact" Title:@"联系我们" subTitle:@"4008-322-686"];
    item0.option = ^(NSIndexPath *indexPath) {
        [weakSelf contactUs];
    };
    
    
    
    YJBaseItem *item1 = [YJBaseItem itemWithTitle:@"关注微博" subTitle:@"立木征信"];
//     YJBaseItem *item2 = [YJArrowItem itemWithIcon:@"me_icon_focus" Title:@"关注微博" subTitle:@"立木征信"];
    item1.option = ^(NSIndexPath *indexPath) {
        [weakSelf followBlog];
    };
    
    YJBaseItem *item2 = [YJBaseItem itemWithTitle:@"公司邮箱" subTitle:@"limu@limuzhengxin.com"];
    //     YJBaseItem *item1 = [YJArrowItem itemWithIcon:@"me_icon_email" Title:@"电子邮箱" subTitle:@"limu@limuzhengxin.com"];
    item2.option = ^(NSIndexPath *indexPath) {
        [weakSelf sendEmail];
    };
    
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0,item1,item2];
    
    [self.dataSource addObject:group];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
    UIFont *font = nil;
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        font = Font13;
    } else {
        font = Font15;
    }
    [cell.accessoryArrowBtn setTitleColor:RGB_navBar forState:(UIControlStateDisabled)];
    cell.accessoryArrowBtn.titleLabel.font = font;
    cell.accessoryArrowBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    cell.accessoryArrowBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25);
    
    YJItemGroup *group = self.dataSource[indexPath.section];
    YJBaseItem *item = group.groups[indexPath.row];
    cell.item = item;
    
    if (group.groups.count-1 == indexPath.row) {
        UIView *separateLine1 = [[UIView alloc] init];
        separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
        separateLine1.backgroundColor = RGB_grayLine;
        
        [cell.contentView addSubview:separateLine1];
    }
    
    return cell;
}


#pragma mark---客服电话
- (void)contactUs {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4008200806"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
/**
 *  在APPstore打开应用
 *
 *  @param appId
 */
- (void)openAppStore:(NSString *)appId

{
    
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    
    storeProductVC.delegate = self;
    
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error)
     
     {
         
         if (result)
             
         {
             
             [self presentViewController:storeProductVC animated:YES completion:nil];
             
         }
         
     }];
    
}

//实现SKStoreProductViewControllerDelegate委托的函数
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController

{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark---发邮件
/**
 *  发送邮件
 */
- (void)sendEmail {
    
    if (![MFMailComposeViewController canSendMail]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://limu@limuzhengxin.com"]];
        ;
    } else {
        
        
        if (iOS11) {
            
            [[UINavigationBar appearance] setBarTintColor:RGB_navBar];//背景颜色
            [UINavigationBar appearance].translucent =NO; //不透明设置
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            [mailVC setSubject:@"反馈信息"]; // 主题
            [mailVC setMessageBody:@"反馈内容:" isHTML:NO]; // 内容
            [mailVC setToRecipients:@[@"limu@limuzhengxin.com"]]; // 收件人列表
            mailVC.mailComposeDelegate = self;
            mailVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self.navigationController presentViewController:mailVC animated:YES completion:^{
            }];
        }else{
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            
            //    [UIApplication sharedApplication] openURL:<#(nonnull NSURL *)#>;
            [mailVC setSubject:@"反馈信息"]; // 主题
            [mailVC setMessageBody:@"反馈内容:" isHTML:NO]; // 内容
            [mailVC setToRecipients:@[@"limu@limuzhengxin.com"]]; // 收件人列表
            //    [mailVC setCcRecipients:@[@"582881167@qq.com"]]; // 抄送人列表
            //    [mailVC setBccRecipients:@[@"582881167@qq.com"]]; // 密送人列表
            //
            // 添加附件
            //    UIImage *image = [UIImage imageNamed:@"111.png"];
            //    NSData *data = UIImagePNGRepresentation(image);
            //
            //    [mailVC addAttachmentData:data mimeType:@"image/png "fileName:@"111.png"];
            
            //        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"" ofType:nil]];
            
            mailVC.mailComposeDelegate = self;
            [self presentViewController:mailVC animated:YES completion:nil];
        }
        
    }
    

    
    
    
    
    
    
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    
    MYLog(@"结果%d",result);
    
    
    if (error) {
        
        MYLog(@"错误信息：%@",error);
    }
    
    
}
#pragma mark---关注微博
- (void)followBlog {
    
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://weibo.com/limuzhengxin"];
    [[UIApplication sharedApplication] openURL:url];
}


#pragma mark--弃
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *ID = @"aboutCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
//    }
//    NSString *icon = nil;
//    NSString *title = nil;
//    NSString *subTitle = nil;
//    if (indexPath.row == 0) {
//        icon = @"me_icon_contact";
//        title = @"联系我们";
//        subTitle = @"4008-322-686";
//    } else if (indexPath.row == 1) {
//        icon = @"me_icon_email";
//        title = @"电子邮箱";
//        //        subTitle = @"limu@limuzhengxin.com";
//        subTitle = @"yongjun.wang@99baozi.com";
//    } else if (indexPath.row == 2) {
//        icon = @"me_icon_focus";
//        title = @"关注微博";
//        subTitle = @"立木征信";
//    }
//    cell.imageView.image = [UIImage imageNamed:icon];
//    cell.textLabel.text = title;
//    cell.detailTextLabel.text = subTitle;
//    cell.detailTextLabel.font = Font13;
//    cell.detailTextLabel.textColor = RGB_navBar;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    switch (indexPath.row) {
//        case 0:
//            [self contactUs];
//            break;
//        case 1:
//            [self sendEmail];
//            break;
//        case 2:
//            [self followBlog];
//            break;
//        default:
//            break;
//    }
//    
//}


@end
