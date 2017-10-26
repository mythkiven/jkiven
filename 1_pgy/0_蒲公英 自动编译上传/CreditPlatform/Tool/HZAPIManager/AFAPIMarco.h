//
//  AFAPIMarco.h
//  Mpos
//  Copyright (c) 2015年 jxc. All rights reserved.

 

// 【链接】个人信息
// http://h5.limuzhengxin.com/87c0b146338a4d2682bce0f6a712504b


//////////////////////////////////////////////////////// SDK配置 /////////////////////
//渠道号
#define kChannelSDK @"APP"
#define  lm_CALLBACKURL     @"http://192.168.117.239:8080/credit_callback.php"
static NSString * lm_APIKEY  = @"";
//static NSString * lm_APISECRET   = @"";
static NSString * lm_UID = @"";

// SDK  测试环境
#define  lm_url             @"http://192.168.101.13:8083"
// SDK  生产环境
//#define lm_url               @"https://api.limuzhengxin.com"

//// H5结果页
#define   result_web_url_   lm_url

/////////////////////////////////////////////////////// APP //////////////////////////

//#define SERVE_URL             @"https://app.limuzhengxin.com/app/" //生 产
#define SERVE_URL             @"http://192.168.101.13:8084/app/" // 测试

//#define SERVE_URL              @"http://192.168.117.34:8089/app/" // 龙龙

#define SERVE_URL_YZM          @"https://app.limuzhengxin.com/credit/getCreditPwd" //生常用于忘记密码

////////////////////////////////////////////其他/////////////////////////////////////////////



// 版本
#define urlJK_queryAppVersion       @"queryAppVersion"

/**************用户标准消费服务对应费用**************/
#define urlJK_packageTypeOneAmt  @"packageTypeOneAmt"

// 检测登录
#define urlJK_checkUserLogin @"checkUserLogin"
// 检测退出
#define urlJK_loginOut   @"loginOut"


/**************登录注册 个人模块**************/
//登录接口
#define urlJK_login                 @"login"
//验证码
#define urlJK_sendMobileCode        @"sendMobileCode"
//注册
#define urlJK_register              @"register"
//重置密码
#define urlJK_resetPwdForForgetPwd  @"resetPwdForForgetPwd"
//重置手机号
#define urlJK_modifyMobile          @"modifyMobile"
//重置旧密码
#define urlJK_modifyPwd             @"modifyPwd"
//更换头像
#define urlJK_changePicture         @"changePicture"
//城市列表查询
#define urlJK_queryCities           @"queryCities"

// 短信 注册用户发送验证码
#define APP_REGISTER_AUTHCODE       @"APP_REGISTER_AUTHCODE"
// 短信 忘记密码发送验证码
#define  APP_FORGETPWD_AUTHCODE     @"APP_FORGETPWD_AUTHCODE"
// 短信 修改手机号验证短信
#define  APP_UDMOBLILE_AUTHCODE     @"APP_UDMOBLILE_AUTHCODE"
// 手机号注册？
#define  urlJK_checkUserNameRegister @"checkUserNameRegister"
//验证手机验证码
#define  urlJK_checkMobileCode      @"checkMobileCode"

/************** 👇 **************
*************** 查 **************
*************** 询 **************
*************** 模 **************
*************** 块 **************/

// 1.获取token
/**************1.公积金**************/
#define urlJK_queryHouseFund        @"queryHouseFund"
/**************2.社保**************/
#define urlJK_querySocialsecurity   @"querySocialsecurity"

/**************3.运营商**************/
//1.运营商授权 获取token
#define urlJK_queryMobile           @"queryMobile"
// 发送验证码接口
#define urlJK_mobileSmsCheck        @"mobileSmsCheck"
// 手机号 重置密码
#define urlJK_mobileFindPwd         @"mobileFindPwd"
// 重置
#define urlJK_resetMobilePwd        @"resetMobilePwd"
// 手机号所在地
#define urlJK_queryMobileArea       @"queryMobileArea"
// 支持的信用卡邮箱
#define urlJK_creditEmailType       @"creditEmailType"


/**************4.电商**************/
#define urlJK_queryJd               @"queryJd"
/**************5.央行征信**************/
#define urlJK_queryCredit           @"queryCredit"
/**************6.学历学籍**************/
#define urlJK_queryEducation        @"queryEducation"
/**************7.淘宝**************/
#define urlJK_queryTaobao           @"queryTaobao"
/**************8.脉脉**************/
#define urlJK_queryMaiMai           @"queryMaiMai"
/*************9.领英**************/
#define urlJK_queryLinkedin         @"queryLinkedin"
/**************10.信用卡**************/
#define urlJK_queryCreditcardbill           @"queryCreditcardbill"
/*************11.失信**************/
#define urlJK_queryShixin         @"queryShixin"
/*************12 车险**************/
#define urlJK_queryAutoinsurance         @"queryAutoinsurance"

/*************13 网银**************/
#define urlJK_queryEbank         @"queryEbank"


/************* 车险 公司list**************/
#define urlJK_queryInsuranceCompany         @"queryInsuranceCompany"



/************* 网银 公司list**************/
#define urlJK_appBankInfo         @"appBankInfo"

/**
 *  2.获取状态 data.code=0000代表准备成功，进行下一步
 */
#define urlJK_queryInterfaceStatus         @"queryInterfaceStatus"


/**
 *  3.获取查询结果
 */
#define urlJK_queryResult                  @"queryResult"



/**************  报告  **************/
// 通用查询报告 第一步
#define urlJK_recordListProcess         @"recordListProcess"
// 通用查询报告 第二步
#define urlJK_recordDetailProcess         @"recordDetailProcess"


/************** 👇 **************
 ************* 《我》 **************
 *************** 模 **************
 *************** 块 **************/

/************** 企业认证 **************/
// 认证信息提交
#define urlJK_memberAuth                  @"memberAuth"

// 认证详情
#define urlJK_queryMember                  @"queryMember"

/************** 意见反馈 **************/
#define urlJK_appSuggestions                  @"appSuggestions"



/************** 充值账户信息 **************/
#define urlJK_queryFreeRule               @"queryFreeRule"

/************** 充值账户信息 **************/
#define urlJK_rechargeInfo               @"rechargeInfo"

/************** 公司立木征信银行账户信息 **************/
#define urlJK_companyBankInfo                  @"companyBankInfo"

/************** 提交转账凭证 **************/
#define urlJK_submitTransferInfo                  @"submitTransferInfo"

/************** 充值记录（rechargeType：00充值记录 01红包记录） **************/
#define urlJK_rechargeRecord             @"rechargeRecord"

/************** 充值记录-状态 **************/
#define urlJK_getRechargeRecordStatus             @"getRechargeRecordStatus"

/************** 充值记录-取消 **************/
#define urlJK_rechargeCancel             @"rechargeCancel"

/************** 标准消费记录 **************/
#define urlJK_spendRecord                  @"spendRecord"

/************** 标准消费-子账号 **************/
#define urlJK_queryUserOperatorNames                  @"queryUserOperatorNames"



/************** 套餐消费列表 **************/
#define urlJK_appPackconsu                  @"appPackconsu"
/************** 套餐消费详情 **************/
#define urlJK_appPackconsuDetl                  @"appPackconsuDetl"
/************** 获取用户套餐A信息 **************/
#define urlJK_queryUserPackageService          @"queryUserPackageService"
/************** 获取用户套餐B信息 **************/
#define urlJK_appPackconsuDetlB          @"appPackconsuDetlB"

/************** 消费类型记录 **************/
#define urlJK_getSpendRecordService                  @"getSpendRecordService"



/************** 👇 **************
 *************** 母 **************
 *************** 子 **************
 *************** 账 **************
 *************** 号 **************/

/************** 新增 子账号 **************/
#define urlJK_addUserOperator                   @"addUserOperator"

/************** 列表 子账号 **************/
#define urlJK_queryUserOperatorList             @"queryUserOperatorList"

/************** 禁用 子账号 **************/
#define urlJK_closeUserOperator                  @"closeUserOperator"

/************** 解除 子账号禁用 **************/
#define urlJK_openUserOperator                  @"openUserOperator"

/************** 修改 子账号 **************/
#define urlJK_updateUserOperator                  @"updateUserOperator"

/************** 删除 子账号 **************/
#define urlJK_deleteUserOperator                  @"deleteUserOperator"







/************** 👇 **************
 *************** 支 **************
 *************** 付 **************/

/************** 支付宝订单加签 **************/
#define urlJK_orderPaySignWithAlipay                  @"orderPaySignWithAlipay"
/************** 支付宝支付状态核对接口 **************/
#define urlJK_checkOrderPayStatusWithAlipay                  @"checkOrderPayStatus"

//微信下单接口
#define urlJK_orderPaySignWithWeiXinPay                     @"orderPaySignWithWeiXinPay"


#define kplaceholderImage  [UIImage imageNamed:@"teamPic"]
#define kplaceholderImageHostTeamPic   [UIImage imageNamed:@"HostTeamPic"]
#define kplaceholderImageGuestTeamPic   [UIImage imageNamed:@"GuestTeamPic"]






