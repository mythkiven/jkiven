//
//  YJRefreshGifHeader.m
//  CreditPlatform
//
//  Created by yj on 2016/11/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRefreshGifHeader.h"

@implementation YJRefreshGifHeader

+ (instancetype)yj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    YJRefreshGifHeader *cmp = (YJRefreshGifHeader *)[MJRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
    
    NSMutableArray *pullImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    NSMutableArray *shakeImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    
    cmp.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    cmp.stateLabel.hidden = YES;
    
    [cmp setImages:pullImgs forState:(MJRefreshStatePulling)];
    [cmp setImages:shakeImgs forState:(MJRefreshStateRefreshing)];
    
    
    
    return cmp;
}







/**
 *  刷新控件动画组
 *
 */
+ (NSMutableArray *)animationImagesWithName:(NSString *)name count:(int)count {
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i <= count; i ++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%d",name,i];
        
        UIImage *img = [UIImage imageNamed:imgName];
        
        [imgArr addObject:img];
    }
    return imgArr;
}


@end

/*
 NSMutableArray *pullImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
 
 NSMutableArray *shakeImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
 
 // 下拉刷新
 _refreshGifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
 
 //
 [weakSelf loadChildAccountData];
 
 }];
 
 _refreshGifHeader.lastUpdatedTimeLabel.hidden = YES;
 // 隐藏状态
 _refreshGifHeader.stateLabel.hidden = YES;
 
 [_refreshGifHeader setImages:pullImgs forState:(MJRefreshStatePulling)];
 [_refreshGifHeader setImages:shakeImgs forState:(MJRefreshStateRefreshing)];
 self.tableView.mj_header = _refreshGifHeader;
 */
