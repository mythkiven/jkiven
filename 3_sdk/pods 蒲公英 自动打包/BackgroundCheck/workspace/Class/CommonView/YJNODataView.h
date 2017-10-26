//
//  YJNODataView.h
//  CreditPlatform
//
//  Created by yj on 16/8/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum { // 无记录
    NODataTypeRedNormal, // 无数据
    NODataTypeRedPacket, //无红包
    NODataTypeRecharge, // 无充值
    NODataTypepurchase, // 无消费
    NODataTypeChildAccount // 无子账号
}NODataType;

@interface YJNODataView : UIView
+ (instancetype)NODataView;

+ (instancetype)NODataView:(NODataType)type;
@end
