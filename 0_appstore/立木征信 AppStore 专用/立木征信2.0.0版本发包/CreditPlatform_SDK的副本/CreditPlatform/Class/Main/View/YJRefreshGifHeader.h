//
//  YJRefreshGifHeader.h
//  CreditPlatform
//
//  Created by yj on 2016/11/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface YJRefreshGifHeader : MJRefreshGifHeader
+ (instancetype)yj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

+ (instancetype)yj_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end
