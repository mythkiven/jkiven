//
//  JComboPurchaseB.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JComboPurchaseBListModel : NSObject


@property (copy,nonatomic) NSString      *amt;
@property (copy,nonatomic) NSString      *apiId;
@property (copy,nonatomic) NSString      *apiType;
@property (copy,nonatomic) NSString      *consuDate;
@property (copy,nonatomic) NSString      *consuPackageBillId;
@property (copy,nonatomic) NSString      *createDate;
@property (copy,nonatomic) NSString      *discount;
@property (copy,nonatomic) NSString      *id;
@property (copy,nonatomic) NSString      *identityCardNo;
@property (copy,nonatomic) NSString      *identityName;
@property (copy,nonatomic) NSString      *price;
@property (copy,nonatomic) NSString      *queryCount;
@property (copy,nonatomic) NSString      *remark;
@property (copy,nonatomic) NSString      *status;
@property (copy,nonatomic) NSString      *updateDate;
@property (copy,nonatomic) NSString      *userId;
@property (copy,nonatomic) NSString      *apiTypeName;

@end
@class JComboPurchaseBDataModel;
@interface JComboPurchaseBModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSDictionary       *data;
@property (copy,nonatomic) JComboPurchaseBDataModel       *jComboPurchaseBDataModel;
@property (copy,nonatomic) NSArray       *list;
@property (copy,nonatomic) NSString      *msg;
@property (copy,nonatomic) NSString      *success;

@end

@interface JComboPurchaseBDataModel : NSObject
@property (copy,nonatomic) NSString      *amt;
@property (copy,nonatomic) NSString      *consuDate;
@property (copy,nonatomic) NSString      *createDate;
@property (copy,nonatomic) NSString      *packConsuId;
@property (copy,nonatomic) NSString      *packageSerialNo;
@property (copy,nonatomic) NSString      *servicePackageName;
@property (copy,nonatomic) NSString      *settleStatus;
@property (copy,nonatomic) NSString      *spileTime;
@property (copy,nonatomic) NSString      *total;

@end
