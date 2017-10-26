//
//  LMZXLoadingFunctionTypeModel.h
//  LMZX_SDK_Develop
//
//  Created by gyjrong on 17/5/17.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#define LMZX_PARAM_IS_NIL_ERROR(param) ((param == nil || [param isKindOfClass:[NSNull class]]) ? @"" : param)
#define  LMZX_LAST_WEBLOGIN_INFO @"LMZX_LAST_WEBLOGIN_INFO"



#import <Foundation/Foundation.h>


@class LMZXWebLoginModel;
@interface LMZXWebLoadingType : NSObject



@property (copy,nonatomic) NSString      *mail_sina;
@property (copy,nonatomic) NSString      *mail_163;
@property (copy,nonatomic) NSString      *mail_126;
@property (copy,nonatomic) NSString      *mail_139;
@property (copy,nonatomic) NSString      *mail_qq;
@property (copy,nonatomic) NSString      *ctrip;
@property (copy,nonatomic) NSString      *maimai;
@property (copy,nonatomic) NSString      *linkedin;
@property (copy,nonatomic) NSString      *taobao;
@property (copy,nonatomic) NSString      *diditaxi;
@property (copy,nonatomic) NSString      *jd;

-(BOOL)saveLastWebLoginInfo:(id)obj;

-(void)removeLastWebLoginInfo;

-(LMZXWebLoginModel *)getLastWebLoginInfo:(NSString*)type;
@end



@class LMZXWebLoginItemsModel;
@interface LMZXWebLoginModel : NSObject<NSCoding>

@property (copy,nonatomic) NSString      *type;
@property (copy,nonatomic) NSString      *bizType;
@property (copy,nonatomic) NSString      *category;
@property (copy,nonatomic) NSString      *status;
@property (strong,nonatomic) LMZXWebLoginItemsModel  *items;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface LMZXWebLoginItemsModel : NSObject<NSCoding>
@property (copy,nonatomic) NSString      *logo;
@property (copy,nonatomic) NSString      *loginType;
@property (copy,nonatomic) NSString      *loginUrl;
@property (copy,nonatomic) NSArray       *loginInputUrl;
@property (copy,nonatomic) NSArray       *successUrl;
@property (copy,nonatomic) NSArray       *jsUrl;
@property (copy,nonatomic) NSString      *userAgent;
@property (copy,nonatomic) NSString      *isWebLogin;


@end
