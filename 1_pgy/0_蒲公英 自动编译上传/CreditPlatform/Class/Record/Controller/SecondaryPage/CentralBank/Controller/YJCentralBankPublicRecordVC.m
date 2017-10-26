//
//  YJCentralBankPublicRecordVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankPublicRecordVC.h"

@interface YJCentralBankPublicRecordVC ()
{
    UIScrollView *_scroollView;
    UILabel *_contentLabel;
}


@end

@implementation YJCentralBankPublicRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公共描述";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGB_pageBackground;
    
    if (self.publicRecordModel.descrip) {
        [self creatUI];
    } else {
        
        [self.view addSubview:[YJNODataView NODataView]];
    }

    


}


- (void)creatUI {
    // 上分割线
    CGFloat margin = 10;
    UIView *line0 = [UIView new];
    line0.backgroundColor = RGB_grayLine;
    line0.frame = CGRectMake(0, margin, SCREEN_WIDTH, 0.5);
    [self.view addSubview:line0];
    
    
    _scroollView = [UIScrollView new];
    _scroollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scroollView];
    _scroollView.frame =CGRectMake(0, CGRectGetMaxY(line0.frame), SCREEN_WIDTH, SCREEN_HEIGHT-margin-64);
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [_scroollView addSubview:bgView];

    
    // 内容
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, margin, SCREEN_WIDTH-30, 40)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = Font15;
    contentLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:contentLabel];
//    self.publicRecordModel.descrip = @"dfasfasdfasdfasdfds在IOS开发领域，由于Apple严格的审核标准和低效率，IOS应用的发版速度极慢，稍微大型的app发版基本上都在一个月以上，所以代码热更新（HotfixPatch）对于IOS应用来说就显得尤其重要。    现在业内基本上都在使用WaxPatch方案，由于Wax框架已经停止维护四五年了，所以waxPatch在使用过程中还是存在不少坑(比如参数转化过程中的问题，如果继承类没有实例化修改继承类的方法无效, wax_gc中对oc中instance的持有延迟释放...)。另外苹果对于Wax使用的态度也处于模糊状态，这也是一个潜在的使用风险。    随着FaceBook开源React Native框架，利用JavaScriptCore.framework直接建立JavaScript（JS）和Objective-C(OC)之间的bridge成为可能，JSPatch也在这个时候应运而生。最开始是从唐巧的微信公众号推送上了解到，开始还以为是在React Native的基础上进行的封装，不过最近仔细研究了源代码，跟React Native半毛钱关系都没有，这里先对JSPatch的作者（不是唐巧，是Bang，博客地址）赞一个。    深入了解JSPatch之后，第一感觉是这个方案小巧，易懂，维护成本低，直接通过OC代码去调用runtime的API，作为一个IOS开发者，很快就能看明白，不用花大精力去了解学习lua。另外在建立JS和OC的Bridge时，作者很巧妙的利用JS和OC两种语言的消息转发机制做了很优雅的实现，稍显不足的是JSPatch只能支持ios7及以上。    由于现在公司的部分应用还在支持ios6，完全取代Wax也不现实，但是一些新上应用已经直接开始支持ios7。个人觉得ios6和ios7的界面风格差别较大，相信应用最低支持版本会很快升级到ios7. 还考虑到JSPatch的成熟度不够，所以决定把JSPatch和WaxPatch结合在一起，相互补充进行使用。下面给大家说一些学习使用体会。";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.publicRecordModel.descrip];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.publicRecordModel.descrip.length)];
    
    contentLabel.attributedText = attributedString;
    CGSize size = CGSizeMake(contentLabel.bounds.size.width, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    CGRect frame = contentLabel.frame;
    frame.size = labelSize;
    contentLabel.frame = frame;
    
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, contentLabel.frame.size.height+20);
    
    _scroollView.contentSize = CGSizeMake(0, CGRectGetMaxY(contentLabel.frame)+10);
    
    CGFloat line1Y = CGRectGetMaxY(bgView.frame);
    if (line1Y >= CGRectGetMaxY(_scroollView.frame)) {
        line1Y = SCREEN_HEIGHT-30-64;
        //        line1Y = CGRectGetMaxY(_scroollView.frame);
    } else {
        line1Y += 10;
        UIView *line1 = [UIView new];
        line1.frame = CGRectMake(0, line1Y, SCREEN_WIDTH, 0.5);
        line1.backgroundColor = RGB_grayLine;
        [self.view addSubview:line1];
        
    }
    
    
    MYLog(@"%f------%f",line1Y,CGRectGetMaxY(_scroollView.frame));

}


@end
