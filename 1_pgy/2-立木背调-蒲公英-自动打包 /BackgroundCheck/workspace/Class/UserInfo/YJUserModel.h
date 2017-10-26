//
//  YJUserModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//


@interface YJUserModel : NSObject
/**
 *  用户名
 */
@property (copy,nonatomic) NSString  *username;
/**
 *  用户手机号
 */
@property (copy,nonatomic) NSString  *mobile;
/**
 *  用户密码
 */
@property (copy,nonatomic) NSString  *userPwd;
/**
 *  用户头像base64字符串
 */
@property (copy,nonatomic) NSString  *picture;
/**
 *  用户授权认证状态 0未认证 - 1认证
 */
@property (copy,nonatomic) NSString  *authQualifyFlag;

/**
 *  用户授权认证状态 // 00-待审核 20-审核成功 99-审核失败（手动添加未认证状态：0）
 */
@property (copy,nonatomic) NSString  *authStatus;

/**
 *  用户是否登录
 */
@property (assign,nonatomic,getter=isLogin) BOOL login;

/**
 *  用户头像
 */
@property (weak,nonatomic) UIImage  *iconImage;

/**
 *  3 表示具备创建子账号权限
 */
@property (copy,nonatomic) NSString  *masterStatus;

/**
 *  apikey
 */
@property (copy,nonatomic) NSString  *apiKey;


/**
 *  企业名称
 */
@property (copy,nonatomic) NSString  *companyName;


///**
// *  秘钥
// */
//@property (copy,nonatomic) NSString  *aesKey;

///**
// *  APP 专用  --->SDK
// */
//@property (copy,nonatomic) NSString  *channel;


@end
