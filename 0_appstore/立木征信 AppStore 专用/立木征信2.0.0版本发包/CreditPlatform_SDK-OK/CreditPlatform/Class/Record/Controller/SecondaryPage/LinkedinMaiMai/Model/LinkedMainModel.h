//
//  LinkedMainModel.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class cardInfoLY,baseInfoLY,workInfoLY,educationInfoLY,friendInfoLY;
@interface LinkedMainModel : NSObject
@property (copy,nonatomic) NSString      *cid;
@property (copy,nonatomic) cardInfoLY      *cardInfo;
@property (copy,nonatomic) baseInfoLY     *baseInfo;
@property (copy,nonatomic) NSArray      *workExps;
@property (copy,nonatomic) NSArray *educationExps;
@property (copy,nonatomic) NSArray    *friendInfos;
@end

@interface cardInfoLY : NSObject
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString      *gender;
@property (copy,nonatomic) NSString      *vocation;
@property (copy,nonatomic) NSString      *rank;
@property (copy,nonatomic) NSString      *company;
@property (copy,nonatomic) NSString      *position;
@property (copy,nonatomic) NSString      *composAuth;
@property (copy,nonatomic) NSString      *workProvince;
@property (copy,nonatomic) NSString      *workCity;
@property (copy,nonatomic) NSString      *workAddress;
@property (copy,nonatomic) NSString      *no;
@property (copy,nonatomic) NSString      *mobile;
@property (copy,nonatomic) NSString      *email;

@end

@interface baseInfoLY : NSObject
@property (copy,nonatomic) NSString      *freindNum;
@property (copy,nonatomic) NSString      *myZhima;
@property (copy,nonatomic) NSString      *myInteract;
@property (copy,nonatomic) NSString      *myFeed;
@property (copy,nonatomic) NSString      *myArticle;
@property (copy,nonatomic) NSString      *myOpinion;
@property (copy,nonatomic) NSString      *myComment;
@property (copy,nonatomic) NSString      *htProvince;
@property (copy,nonatomic) NSString      *htCity;
@property (copy,nonatomic) NSString      *birthday;
@property (copy,nonatomic) NSString      *myIntroduction;
@property (copy,nonatomic) NSString      *weiboTags;
@end

@interface workInfoLY : NSObject
@property (copy,nonatomic) NSString      *company;
@property (copy,nonatomic) NSString      *authStatus;
@property (copy,nonatomic) NSString      *position;
@property (copy,nonatomic) NSString      *startDate;
@property (copy,nonatomic) NSString      *endDate;
@property (copy,nonatomic) NSString      *workDesc;
@property (copy,nonatomic) NSString      *remark;
@end

@interface educationInfoLY : NSObject
@property (copy,nonatomic) NSString      *school;
@property (copy,nonatomic) NSString      *authStatus;
@property (copy,nonatomic) NSString      *major;
@property (copy,nonatomic) NSString      *degree;
@property (copy,nonatomic) NSString      *startDate;
@property (copy,nonatomic) NSString      *endDate;
@property (copy,nonatomic) NSString      *educationDesc;
@property (copy,nonatomic) NSString      *remark;
@end
@interface friendInfoLY : NSObject
@property (copy,nonatomic) NSString      *cid;
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString      *phone;
@property (copy,nonatomic) NSString      *email;
@property (copy,nonatomic) NSString      *company;
@property (copy,nonatomic) NSString      *position;
@property (copy,nonatomic) NSString      *composAuth;
@property (copy,nonatomic) NSString      *gender;
@property (copy,nonatomic) NSString      *rank;
@property (copy,nonatomic) NSString      *dist;
@property (copy,nonatomic) NSString      *relationDesc;
@end
